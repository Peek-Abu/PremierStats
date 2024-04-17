from datetime import datetime
import random
import click
from flask.cli import with_appcontext
from app.database import db
from app.models import Country, Referee, Stadium, Manager, Team, Odds, Match, Stats, Player, Event, Assist, League

@click.command(name='seed_db')
@with_appcontext
def seed_db():
    """Populates the database with dummy data."""
    countries = [Country(c_name="England", leagues_hosted=None), Country(c_name="CountryB", leagues_hosted=3)]
    referees = [Referee(ref_id=1, age=45, name="Ref A", games_reffed=100), Referee(ref_id=2, age=40, name="Ref B", games_reffed=80)]
    stadiums = [Stadium(stadium_id=1, name = "Anfield", seats=50000, founded=datetime(1990, 5, 12)), 
                Stadium(stadium_id=2, name = "Stadium 2", seats=30000, founded=datetime(1985, 7, 14))]
    managers = [Manager(manager_id=1, name="Manager A", age=50, years_managing=10, titles_managed=2), 
               Manager(manager_id=2, name="Manager B", age=45, years_managing=5, titles_managed=1)]
    teams = [Team(t_name="Liverpool", manager_id = 1, nationality="England", founded=datetime(1990, 5, 12), total_titles=5, historical_performance=8, home_stadium=1, league_name="Premier League"),
                Team(t_name="Team B", manager_id = 2, nationality="CountryB", founded=datetime(1995, 5, 12), total_titles=3, historical_performance=6, home_stadium=2, league_name="La Liga")]
    odds = [Odds(odds_id=1, under_odds=2, over_odds=3), Odds(odds_id=2, under_odds=3, over_odds=2)]
    matches = [Match(match_id=1, ref=1, game_date=datetime(2021, 5, 12), venue=1, home="Liverpool", away="Team B", scoreline="1-0", attendance=42000, odds_id=1),
                Match(match_id=2, ref=2, game_date=datetime(2021, 5, 12), venue=2, home="Team B", away="Liverpool", scoreline="2-2", attendance=30000, odds_id=2)]
    stats = [Stats(stats_id=1, goals=2, appearances=10, assists=3), 
             Stats(stats_id=2, goals=1, appearances=5, assists=1)]
    players = [Player(player_id=1, p_name="Player A", nationality = "England", position="Forward", age=25, team_name="Liverpool", player_stats=1),
                Player(player_id=2, p_name="Player B", nationality = "CountryB", position="Midfielder", age=30, team_name="Team B", player_stats=2)]
    events = [Event(event_id=1, match_id=1, event_type="Goals", player_involved=1, description="Bicycle kick", minute=30, ),
                Event(event_id=2, match_id=1, event_type="Cards", player_involved=2, description="Red card awarded", minute=60)]
    assists = [Assist(assist_id=1, assisting_player=2, goal=1)]
    leagues = [League(league_name="Premier League", country_name = "England", founded = datetime(1992, 2, 20), total_teams = 20, total_games = 380), 
               League(league_name="La Liga", country_name = "CountryB", founded = datetime(1995, 3, 20), total_teams = 20, total_games = 380)]

    db.session.add_all(countries + referees + stadiums + managers + teams + odds + matches + stats + players + events + assists + leagues)
    
    db.session.commit()
    print("Database has been seeded.")

@click.command(name='reset_db')
@with_appcontext
def reset_db():
    """Drops all tables and recreates them."""
    db.drop_all()
    db.create_all()
    print("Database has been reset.")

@click.command(name='seed_csv_data')
@with_appcontext
def seed_csv_data():
    """Populates the database with data from CSV files."""
    countries = set()
    referees = {}
    stadiumsSet = {}
    stadiums = []
    teams = []
    matches = []
    odds = []
    stats = []
    players = []
    matchMap = {}
    refereesTable = []
    events = []
    assists = []
    # Create countries
    with open('Data/england-premier-league-players-2018-to-2019-stats.csv', 'r', encoding='utf-8') as file:
        next(file)  # Skip the header row
        for index, line in enumerate(file):
            data = line.strip().split(',')
            countries.add(data[11])  

            new_stats = Stats(
                stats_id=(index + 1),
                goals=data[15],
                appearances=data[12],
                assists=data[18]
            )
            stats.append(new_stats)

            new_player = Player(
                p_name=data[0],
                nationality=data[11],
                position=data[6],
                age=data[1],
                team_name=data[7],
                player_stats=(index + 1)
            )       
            players.append(new_player)
    # Create referees and stadiums
    with open('Data/england-premier-league-matches-2018-to-2019-stats.csv', 'r', encoding='utf-8') as file:
        next(file)  # Skip the header row
        for index, line in enumerate(file):
            data = line.strip().split(',')
            referee = data[6]  # Assuming the referee is at index 6
            if referee in referees:
                referees[referee] += 1
            else:
                referees[referee] = 1
            attendance = int(data[3])  # Assuming the attendance is at index 3

            stadium = data[-1]
            stadiumsSet[stadium] = max(stadiumsSet.get(stadium) or 0, attendance)

            # Create an Odds object
            odds_home_win = float(data[-10])  # Assuming the odds for home team win are at the 10th index from the end
            # odds_draw = float(data[-9])  # Assuming the odds for draw are at the 9th index from the end
            odds_away_win = float(data[-8])  # Assuming the odds for away team win are at the 8th index from the end
            oddsObject = Odds(odds_id=(index + 1), under_odds=odds_home_win, over_odds=odds_away_win)
             # Create a Match object
            match_date = datetime.strptime(data[1], '%b %d %Y - %I:%M%p')     
            home_team = data[4]  # Assuming the home team name is at index 4
            away_team = data[5]  # Assuming the away team name is at index 5
            scoreline = f"{data[12]}-{data[13]}"  # Assuming the home and away team goal counts are at indices 12 and 13
            match = Match( game_date=match_date, venue=stadium, home=home_team, away=away_team, scoreline=scoreline, attendance=attendance, odds_id=(index + 1))
            # matches.append(match)
            matchMap[match] = referee
            odds.append(oddsObject)
            
    leagues = [League(league_name="Premier League", country_name="England", founded=datetime.strptime("1992-02-20", '%Y-%m-%d'), total_teams=20, total_games=380)]
    countries = [Country(c_name=country, leagues_hosted=country == "England" and 1 or 0) for country in countries]
    managers = [
        Manager(name="Unai Emery", age=38, years_managing=0, titles_managed=0), # Arsenal
        Manager(name="Mauricio Pochettino", age=48, years_managing=0, titles_managed=0), # Tottenham
        Manager(name="Pep Guardiola", age=49, years_managing=0, titles_managed=0), # Manchester City
        Manager(name="Brendan Rodgers", age=47, years_managing=0, titles_managed=0), # Leicester
        Manager(name="Roy Hodgson", age=60, years_managing=0, titles_managed=0), # Crystal Palace
        Manager(name="Marco Silva", age=43, years_managing=0, titles_managed=0), # Everton
        Manager(name="Sean Dyche", age=49, years_managing=0, titles_managed=0), # Burnley
        Manager(name="Ralph Hasenhuttl", age=52, years_managing=0, titles_managed=0), # Southampton
        Manager(name="Eddie Howe", age=42, years_managing=0, titles_managed=0), # Bournemouth
        Manager(name="Ole Gunnar Solskjaer", age=47, years_managing=0, titles_managed=0), # Manchester United
        Manager(name="Jurgen Klopp", age=53, years_managing=0, titles_managed=0), # Liverpool
        Manager(name="Maurizio Sarri", age=42, years_managing=0, titles_managed=0), # Chelsea
        Manager(name="Manuel Pellegr", age=65, years_managing=0, titles_managed=0), # West Ham
        Manager(name="Javi Gracia", age=50, years_managing=0, titles_managed=0), # Watford
        Manager(name="Rafael Benitez", age=60, years_managing=0, titles_managed=0), # Newcastle
        Manager(name="Neil Warnock", age=70, years_managing=0, titles_managed=0), # Cardiff
        Manager(name="Scott Parker", age=40, years_managing=0, titles_managed=0), # Fulham
        Manager(name="Chris Hughton", age=50, years_managing=0, titles_managed=0), # Brighton
        Manager(name="Jan Siewert", age=38, years_managing=0, titles_managed=0), # Huddersfield
        Manager(name="Nuno Espirito Santo", age=46, years_managing=0, titles_managed=0), # Wolves
    ]
    with open('Data/england-premier-league-teams-2018-to-2019-stats.csv', 'r', encoding='utf-8') as file:
        next(file)
        for index, line in enumerate(file):
            data = line.strip().split(',')
            team = Team(t_name=data[1], 
                        manager_id=(index + 1),
                        nationality=data[3],
                        founded=datetime.strptime("1995-10-23", '%Y-%m-%d'),
                        total_titles=2,
                        historical_performance=3,
                        # home_stadium=0,
                        league_name="Premier League")
            teams.append(team)
    currIndex = 1
    for referee, games_reffed in referees.items():
        refereeObject = Referee(age=random.randint(30, 60), name=referee, games_reffed=games_reffed)
        refereesTable.append(refereeObject)
        for match, matchReferee in matchMap.items():
            if matchReferee == referee:
                match.ref = currIndex
                matches.append(match)
        currIndex += 1
        
    currIndex = 1
    for stadiumName, stadiumAttendance in stadiumsSet.items():
        stadium = Stadium(stadium_id=currIndex, stadium_name=stadiumName, seats=stadiumAttendance, founded=datetime.strptime("1995-10-23", '%Y-%m-%d'))
        stadiums.append(stadium)
        for match in matches:
            if match.venue == stadiumName:
                match.venue = currIndex
        for team in teams:
            if team.t_name == "Arsenal" and "Emirates Stadium (London)" == stadiumName:
                team.home_stadium = currIndex
            elif team.t_name == "Manchester City" and "Etihad Stadium (Manchester)" == stadiumName:
                team.home_stadium = currIndex
            elif team.t_name == "Manchester United" and "Old Trafford (Manchester)" == stadiumName:
                team.home_stadium = currIndex
            elif team.t_name == "Leicester City" and "King Power Stadium (Leicester- Leicestershire)" == stadiumName:
                team.home_stadium = currIndex
            elif team.t_name == "Crystal Palace" and "Selhurst Park (London)" == stadiumName:
                team.home_stadium = currIndex
            elif team.t_name == "Everton" and "Goodison Park (Liverpool)" == stadiumName:
                team.home_stadium = currIndex
            elif team.t_name == "AFC Bournemouth" and "Vitality Stadium (Bournemouth- Dorset)" == stadiumName:
                team.home_stadium = currIndex
            elif team.t_name == "Chelsea" and "Stamford Bridge (London)" == stadiumName:
                team.home_stadium = currIndex
            elif team.t_name == "West Ham United" and "London Stadium (London)" == stadiumName:
                team.home_stadium = currIndex
            elif team.t_name == "Newcastle United" and "St. James' Park (Newcastle upon Tyne)" == stadiumName:
                team.home_stadium = currIndex
            elif team.t_name == "Fulham" and "Craven Cottage (London)" == stadiumName:
                team.home_stadium = currIndex
            elif team.t_name == "Brighton & Hove Albion" and "The American Express Community Stadium (Falmer- East Sussex)" == stadiumName:
                team.home_stadium = currIndex
            elif team.t_name == "Huddersfield Town" and "John Smith's Stadium (Huddersfield- West Yorkshire)" == stadiumName:
                team.home_stadium = currIndex
            elif team.t_name == "Wolverhampton Wanderers" and "Molineux Stadium (Wolverhampton- West Midlands)" == stadiumName:
                team.home_stadium = currIndex
            elif team.t_name == "Liverpool" and "Anfield (Liverpool)" == stadiumName:
                team.home_stadium = currIndex
            elif team.t_name in stadiumName and team.t_name != "Liverpool":
                team.home_stadium = currIndex
                break
        currIndex += 1 

    
    events = [
        Event(match_id=6, player_involved=411, description='Goal', event_type='Goals', minute=20),
        Event(match_id=1, player_involved=2, description='Yellow card', event_type='Cards', minute=30),
        Event(match_id=14, player_involved=3, description='Substitution', event_type='Substitutions', minute=80),
        Event(match_id=17, player_involved=200, description='Goal', event_type='Goals', minute=90),
        Event(match_id=24, player_involved=5, description='Red card', event_type='Cards', minute=70),
        Event(match_id=24, player_involved=6, description='Substitution', event_type='Substitutions', minute=85),
        Event(match_id=17, player_involved=200, description='Goal', event_type='Goals', minute=60),
    ]

    assists = [
        Assist(assisting_player=551, goal=1),
        Assist(assisting_player=84, goal=4),
        Assist(assisting_player=84, goal=7)
    ]

    db.session.add_all(leagues + countries + refereesTable + managers + stadiums + teams + matches + odds + stats + players + events + assists)
    db.session.commit()
    print("Database has been seeded with CSV data.")