from flask import render_template, Blueprint, redirect, url_for
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

@app.route('/teams')
def Teams():
    all_teams = Team.query.all()
    return render_template('Teams/teams.html', teams=all_teams)

@app.route('/odds')
def Odds():
    all_odds = Odds.query.all()
    return render_template('odds.html', odds=all_odds)

@app.route('/stats')
def Stats():
    all_stats = Stats.query.all()
    return render_template('stats.html', stats=all_stats)
