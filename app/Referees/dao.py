from flask import request
from app.database import db
from app.models import Referee

def createReferee():
    age = request.form['age']
    name = request.form['name']
    games_reffed = request.form['games_reffed']

    new_referee = Referee(age=age, name=name, games_reffed=games_reffed)
    db.session.add(new_referee)
    db.session.commit()
    return new_referee

def getAllReferees():
    return Referee.query.all()

def getReferee(ref_id):
    return Referee.query.get_or_404(ref_id)

def updateReferee(ref_id):
    referee = getReferee(ref_id)
    referee.age = request.form['age']
    referee.name = request.form['name']
    referee.games_reffed = request.form['games_reffed']
    db.session.commit()
    return referee

def deleteReferee(ref_id):
    referee = getReferee(ref_id)
    db.session.delete(referee)
    db.session.commit()
