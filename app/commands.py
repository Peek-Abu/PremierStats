from datetime import datetime
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