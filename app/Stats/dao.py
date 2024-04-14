from flask import request
from app.database import db
from app.models import Stats

def createStats():
    stats_id = request.form['stats_id']
    goals = request.form['goals']
    appearances = request.form['appearances']
    assists = request.form['assists']

    new_stats = Stats(stats_id=stats_id, goals=goals, appearances=appearances, assists=assists)
    db.session.add(new_stats)
    db.session.commit()
    return new_stats

def getAllStats():
    return Stats.query.all()

def getStats(stats_id):
    return Stats.query.get_or_404(stats_id)

def updateStats(stats_id):
    stats = getStats(stats_id)
    stats.goals = request.form['goals']
    stats.appearances = request.form['appearances']
    stats.assists = request.form['assists']
    db.session.commit()
    return stats

def deleteStats(stats_id):
    stats = getStats(stats_id)
    db.session.delete(stats)
    db.session.commit()