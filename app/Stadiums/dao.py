from datetime import datetime
from flask import request
from app.database import db
from app.models import Stadium

def createStadium():
    name = request.form['name']
    seats = request.form['seats']
    founded = request.form['founded']
    founded_date = datetime.strptime(founded, '%Y-%m-%d').date()
    new_stadium = Stadium(name=name, seats=seats, founded=founded_date)
    db.session.add(new_stadium)
    db.session.commit()
    return new_stadium

def getAllStadiums():
    return Stadium.query.all()

def getStadium(stadium_id):
    return Stadium.query.get_or_404(stadium_id)

def updateStadium(stadium_id):
    stadium = getStadium(stadium_id)
    stadium.name = request.form['name']
    stadium.seats = request.form['seats']
    founded = request.form['founded']
    stadium.founded = datetime.strptime(founded, '%Y-%m-%d').date()
    db.session.commit()
    return stadium

def deleteStadium(stadium_id):
    stadium = getStadium(stadium_id)
    db.session.delete(stadium)
    db.session.commit()