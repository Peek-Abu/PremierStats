from flask import request
from app.database import db
from app.models import Odds

def createOdds():
    under_odds = request.form['under_odds']
    over_odds = request.form['over_odds']

    new_odds = Odds(under_odds=under_odds, over_odds=over_odds)
    db.session.add(new_odds)
    db.session.commit()
    return new_odds

def getAllOdds():
    return Odds.query.all()

def getOdds(odds_id):
    return Odds.query.get_or_404(odds_id)

def updateOdds(odds_id):
    odds = getOdds(odds_id)
    odds.under_odds = request.form['under_odds']
    odds.over_odds = request.form['over_odds']
    db.session.commit()
    return odds

def deleteOdds(odds_id):
    odds = getOdds(odds_id)
    db.session.delete(odds)
    db.session.commit()