from flask import request

from app.database import db
from app.models import Event


def createEvent():
    match_id = request.form['match_id']
    player_involved = request.form['player_involved']
    description = request.form['description']
    event_type = request.form['event_type']
    minute = request.form['minute']

    new_event = Event(match_id=match_id, player_involved=player_involved, description=description,
                      event_type=event_type, minute=minute)
    db.session.add(new_event)
    db.session.commit()
    return new_event


def getAllEvents():
    return Event.query.all()


def getEvent(event_id):
    return Event.query.get_or_404(event_id)


def updateEvent(event_id):
    event = getEvent(event_id)
    event.match_id = request.form['match_id']
    event.player_involved = request.form['player_involved']
    event.description = request.form['description']
    event.event_type = request.form['event_type']
    event.minute = request.form['minute']
    db.session.commit()
    return event


def deleteEvent(event_id):
    event = getEvent(event_id)
    db.session.delete(event)
    db.session.commit()
