from flask import render_template, Blueprint, redirect, url_for
from app.models import Country, Referee, Stadium, Manager, Team, Odds, Match, Stats, Player, Event, Assist
import app.DAO.managers as manager_dao

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

@app.route('/managers')
def show_managers():
    try:
        all_managers = Manager.query.all()
        return render_template('Managers/managers.html', managers=all_managers)
    except Exception as e:
        return str(e)

@app.route('/managers/<int:manager_id>')
def manager_details(manager_id):
    try:
        manager = manager_dao.get_manager(manager_id)
        return render_template('Managers/manager_details.html', manager=manager)
    except Exception as e:
        return str(e)

@app.route('/update_manager/<int:manager_id>', methods=['POST'])
def update_manager(manager_id):
    try:
        manager_dao.update_manager(manager_id)
        return redirect(url_for('main.show_managers'))
    except Exception as e:
        return str(e)

@app.route('/add_manager', methods=['POST'])
def add_manager():
    try:
        manager_dao.create_manager()
        return redirect(url_for('main.show_managers'))
    except Exception as e:
        return str(e)
    
@app.route('/delete_manager/<int:manager_id>', methods=['POST'])
def delete_manager(manager_id):
    print(manager_id)
    try:
        manager_dao.delete_manager(manager_id)
        return redirect(url_for('main.show_managers'))
    except Exception as e:
        return str(e)