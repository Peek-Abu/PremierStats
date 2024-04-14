from flask import request
from app.database import db
from app.models import League
from datetime import datetime
def createLeague():
    league_name = request.form['league_name']
    country_name = request.form['country_name']
    founded = request.form['founded']
    founded_date = datetime.strptime(founded, '%Y-%m-%d')
    total_teams = request.form['total_teams']
    total_games = request.form['total_games']

    new_league = League(league_name=league_name, country_name=country_name, founded=founded_date, total_teams=total_teams, total_games=total_games)
    db.session.add(new_league)
    db.session.commit()
    return new_league

def getAllLeagues():
    return League.query.all()

def getLeague(league_name):
    return League.query.get_or_404(league_name)

def updateLeague(league_name):
    league = getLeague(league_name)
    league.country_name = request.form['country_name']
    league.founded = datetime.strptime(request.form['founded'], '%Y-%m-%d').date()
    league.total_teams = request.form['total_teams']
    league.total_games = request.form['total_games']
    db.session.commit()
    return league

def deleteLeague(league_name):
    league = getLeague(league_name)
    db.session.delete(league)
    db.session.commit()