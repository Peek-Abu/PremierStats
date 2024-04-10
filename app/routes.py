from flask import render_template
from flask import Blueprint
from app.models import Country, Referee, Stadium, Manager, Team, Odds, Match, Stats, Player, Event, Assist
app = Blueprint('main', __name__)

@app.route('/', methods=['GET'])
def HomePage():
    return render_template('Home/home.html')

@app.route('/countries')
def Countries():
    all_countries = Country.query.all()
    return render_template('countries.html', countries=all_countries)

@app.route('/referees')
def Referees():
    all_referees = Referee.query.all()
    return render_template('referees.html', referees=all_referees)

@app.route('/stadiums')
def Stadiums():
    all_stadiums = Stadium.query.all()
    return render_template('stadiums.html', stadiums=all_stadiums)

@app.route('/managers')
def Managers():
    all_managers = Manager.query.all()
    return render_template('managers.html', managers=all_managers)

@app.route('/teams')
def Teams():
    all_teams = Team.query.all()
    return render_template('Teams/teams.html', teams=all_teams)

@app.route('/odds')
def Odds():
    all_odds = Odds.query.all()
    return render_template('odds.html', odds=all_odds)

@app.route('/matches')
def Matches():
    all_matches = Match.query.all()
    return render_template('matches.html', matches=all_matches)

@app.route('/stats')
def Stats():
    all_stats = Stats.query.all()
    return render_template('stats.html', stats=all_stats)

@app.route('/players')
def Players():
    all_players = Player.query.all()
    return render_template('players.html', players=all_players)

@app.route('/events')
def Events():
    all_events = Event.query.all()
    return render_template('events.html', events=all_events)

@app.route('/assists')
def Assists():
    all_assists = Assist.query.all()
    return render_template('assists.html', assists=all_assists)