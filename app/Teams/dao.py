from flask import request
from datetime import datetime
from app.database import db
from app.models import Team


def createTeam():
    team_name = request.form['t_name']
    manager_id = request.form['manager_id']
    nationality = request.form['nationality']
    date_founded = request.form['founded']
    total_titles = request.form['total_titles']
    historical_performance = request.form['historical_performance']
    home_stadium = request.form['home_stadium']
    league_name = request.form['league_name']

    new_team = Team(t_name=team_name, manager_id=manager_id, nationality=nationality, founded=date_founded,
                    total_titles=total_titles, historical_performance=historical_performance, home_stadium=home_stadium,
                    league_name=league_name)
    db.session.add(new_team)
    db.session.commit()
    return new_team


def getAllTeams():
    return Team.query.all()


def getTeam(team_name):
    return Team.query.get_or_404(team_name)


def updateTeam(team_name):
    team = getTeam(team_name)
    team.manager_id = request.form['manager_id']
    team.nationality = request.form['nationality']
    team.founded = datetime.strptime(request.form['founded'], '%Y-%m-%d')
    team.total_titles = request.form['total_titles']
    team.historical_performance = request.form['historical_performance']
    team.home_stadium = request.form['home_stadium']
    team.league_name = request.form['league_name']
    db.session.commit()
    return team


def deleteTeam(team_name):
    team = getTeam(team_name)
    db.session.delete(team)
    db.session.commit()
