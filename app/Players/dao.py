from flask import request

from app.database import db
from app.models import Player, Stats


def createPlayer():
    p_name = request.form['p_name']
    nationality = request.form['nationality']
    position = request.form['position']
    age = request.form['age']
    team_name = request.form['team_name']
    player_stats = request.form
    # Insert into stats
    goals = request.form['goals']
    appearances = request.form['appearances']
    assists = request.form['assists']
    stats = Stats(goals=goals, appearances=appearances, assists=assists)
    db.session.add(stats)
    db.session.commit()
    print(stats.stats_id)
    new_player = Player(p_name=p_name, nationality=nationality, position=position, age=age, team_name=team_name,
                        player_stats=stats.stats_id)
    db.session.add(new_player)
    db.session.commit()
    return new_player


def getAllPlayers():
    return Player.query.all()


def getPlayer(player_id):
    return Player.query.get_or_404(player_id)


def updatePlayer(player_id):
    player = getPlayer(player_id)
    player.p_name = request.form['p_name']
    player.nationality = request.form['nationality']
    player.position = request.form['position']
    player.age = request.form['age']
    player.team_name = request.form['team_name']
    # Update stats if necessary
    goals = request.form['goals']
    appearances = request.form['appearances']
    assists = request.form['assists']
    stats = Stats.query.get_or_404(player.player_stats)
    if goals:
        stats.goals = goals
    if appearances:
        stats.appearances = appearances
    if assists:
        stats.assists = assists
    db.session.commit()
    return player


def deletePlayer(player_id):
    player = getPlayer(player_id)
    db.session.delete(player)
    db.session.commit()
