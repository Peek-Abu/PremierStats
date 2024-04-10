from app.database import db

class Country(db.Model):
    __tablename__ = 'Country'
    c_name = db.Column(db.String(64), primary_key=True)
    leagues_hosted = db.Column(db.Integer)

class Referee(db.Model):
    __tablename__ = 'Referee'
    ref_id = db.Column(db.Integer, primary_key=True)
    age = db.Column(db.Integer)
    name = db.Column(db.String(64))
    games_reffed = db.Column(db.Integer)

class Stadium(db.Model):
    __tablename__ = 'Stadium'
    stadium_id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(64))
    seats = db.Column(db.Integer)
    founded = db.Column(db.Date)

class Manager(db.Model):
    __tablename__ = 'Manager'
    manager_id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(64))
    age = db.Column(db.Integer)
    years_managing = db.Column(db.Integer)
    titles_managed = db.Column(db.Integer)
    
class Team(db.Model):
    __tablename__ = 'Team'
    t_name = db.Column(db.String(64), primary_key=True)
    manager_id = db.Column(db.Integer, db.ForeignKey('Manager.manager_id'), nullable=True)
    nationality = db.Column(db.String(64), db.ForeignKey('Country.c_name'), nullable=False)
    founded = db.Column(db.Date)
    total_titles = db.Column(db.Integer)
    historical_performance = db.Column(db.Integer)
    home_stadium = db.Column(db.Integer, db.ForeignKey('Stadium.stadium_id'), nullable=False)
    league_name = db.Column(db.String(64), db.ForeignKey('League.league_name'), nullable=False)

    manager = db.relationship('Manager')
    country = db.relationship('Country')
    stadium = db.relationship('Stadium')
    league = db.relationship('League')

class Odds(db.Model):
    __tablename__ = 'Odds'
    odds_id = db.Column(db.Integer, primary_key=True)
    under_odds = db.Column(db.Integer) # Should this be a float?
    over_odds = db.Column(db.Integer) # Should this be a float?

class Match(db.Model):
    __tablename__ = 'Match'
    match_id = db.Column(db.Integer, primary_key=True)
    ref = db.Column(db.Integer, db.ForeignKey('Referee.ref_id'), nullable=False)
    game_date = db.Column(db.Date)
    venue = db.Column(db.Integer, db.ForeignKey('Stadium.stadium_id'), nullable=False)
    home = db.Column(db.String(64), db.ForeignKey('Team.t_name'), nullable=False)
    away = db.Column(db.String(64), db.ForeignKey('Team.t_name'), nullable=False)
    scoreline = db.Column(db.String(64))
    attendance = db.Column(db.Integer)
    odds_id = db.Column(db.Integer, db.ForeignKey('Odds.odds_id'), nullable=False)

    referee = db.relationship('Referee')
    stadium = db.relationship('Stadium')
    home_team = db.relationship('Team', foreign_keys=[home])
    away_team = db.relationship('Team', foreign_keys=[away])
    odds = db.relationship('Odds')

class Stats(db.Model):
    __tablename__ = 'Stats'
    stats_id = db.Column(db.Integer, primary_key=True)
    goals = db.Column(db.Integer)
    appearances = db.Column(db.Integer)
    assists = db.Column(db.Integer)

class Player(db.Model):
    __tablename__ = 'Player'
    player_id = db.Column(db.Integer, primary_key=True)
    p_name = db.Column(db.String(64))
    nationality = db.Column(db.String(64), db.ForeignKey('Country.c_name'), nullable=False)
    position = db.Column(db.String(64))
    age = db.Column(db.Integer)
    team_name = db.Column(db.String(64), db.ForeignKey('Team.t_name'), nullable=True)
    player_stats = db.Column(db.Integer, db.ForeignKey('Stats.stats_id'), nullable=True, unique=True)

    country = db.relationship('Country')
    team = db.relationship('Team')
    stats = db.relationship('Stats')

class Event(db.Model):
    __tablename__ = 'Event'
    event_id = db.Column(db.Integer, primary_key=True)
    match_id = db.Column(db.Integer, db.ForeignKey('Match.match_id'), nullable=False)
    player_involved = db.Column(db.Integer, db.ForeignKey('Player.player_id'), nullable=False)
    description = db.Column(db.String(64))
    event_type = db.Column( db.Enum('Goals', 'Cards', 'Substitutions'), nullable=False)
    minute = db.Column(db.Integer)

    match = db.relationship('Match')
    player = db.relationship('Player')
    
class Assist(db.Model):
    __tablename__ = 'Assist'
    assist_id = db.Column(db.Integer, primary_key=True)
    assisting_player = db.Column(db.Integer, db.ForeignKey('Player.player_id'), nullable=False)
    goal = db.Column(db.Integer, db.ForeignKey('Event.event_id'), nullable=False)

    player = db.relationship('Player')
    event = db.relationship('Event')
    
class League(db.Model):
    __tablename__ = 'League'
    league_name = db.Column(db.String(64), primary_key=True)
    country_name = db.Column(db.String(64), db.ForeignKey('Country.c_name'), nullable=False)
    founded = db.Column(db.Date)
    total_teams = db.Column(db.Integer)
    total_games = db.Column(db.Integer)

    country = db.relationship('Country')
