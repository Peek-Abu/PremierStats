from flask import request

from app.database import db
from app.models import Assist


def createAssist():
    assisting_player = request.form['assisting_player']
    goal = request.form['goal']

    new_assist = Assist(assisting_player=assisting_player, goal=goal)
    db.session.add(new_assist)
    db.session.commit()
    return new_assist


def getAllAssists():
    return Assist.query.all()


def getAssist(assist_id):
    return Assist.query.get_or_404(assist_id)


def updateAssist(assist_id):
    assist = getAssist(assist_id)
    assist.assisting_player = request.form['assisting_player']
    assist.goal = request.form['goal']
    db.session.commit()
    return assist


def deleteAssist(assist_id):
    assist = getAssist(assist_id)
    db.session.delete(assist)
    db.session.commit()
