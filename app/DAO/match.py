from flask import request

from app.database import db
from app.models import Match


def createMatch():
    ref = request.form['ref']
    game_date = request.form['game_date']
    venue = request.form['venue']
    home = request.form['home']
    away = request.form['away']
    scoreline = request.form['scoreline']
    attendance = request.form['attendance']
    odds_id = request.form['odds_id']

    new_match = Match(ref=ref, game_date=game_date, venue=venue, home=home, away=away, scoreline=scoreline,
                      attendance=attendance, odds_id=odds_id)
    db.session.add(new_match)
    db.session.commit()
    return new_match


def getAllMatches():
    return Match.query.all()


def getMatch(match_id):
    return getMatch(match_id)


def updateMatch(match_id):
    match = getMatch(match_id)
    match.ref = request.form['ref']
    match.game_date = request.form['game_date']
    match.venue = request.form['venue']
    match.home = request.form['home']
    match.away = request.form['away']
    match.scoreline = request.form['scoreline']
    match.attendance = request.form['attendance']
    match.odds_id = request.form['odds_id']
    db.session.commit()
    return match


def deleteMatch(match_id):
    match = getMatch(match_id)
    db.session.delete(match)
    db.session.commit()
