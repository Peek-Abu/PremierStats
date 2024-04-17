from flask import request

from app.database import db
from app.models import Player


def createPlayer():
    p_name = request.form['p_name']
    nationality = request.form['nationality']
    position = request.form['position']
    age = request.form['age']
    team_name = request.form['team_name']
    player_stats = request.form['player_stats']

    new_player = Player(p_name=p_name, nationality=nationality, position=position, age=age, team_name=team_name,
                        player_stats=player_stats)
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
    # player.player_stats = request.form['player_stats']
    db.session.commit()
    return player


def deletePlayer(player_id):
    player = getPlayer(player_id)
    db.session.delete(player)
    db.session.commit()
