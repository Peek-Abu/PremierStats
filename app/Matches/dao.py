from flask import request
from datetime import datetime
from app.database import db
from app.models import Match, Odds


def createMatch():
    print(request.form)
    ref = request.form['ref']
    game_date = datetime.strptime(request.form['game_date'], '%Y-%m-%d')
    venue = request.form['venue']
    home = request.form['home']
    away = request.form['away']
    scoreline = request.form['scoreline']
    attendance = request.form['attendance']
    under_odds = request.form['under_odds']
    over_odds = request.form['over_odds']

    # Create a new odds object
    new_odds = Odds(under_odds=under_odds, over_odds=over_odds)
    db.session.add(new_odds)

    new_match = Match(ref=ref, game_date=game_date, venue=venue, home=home, away=away, scoreline=scoreline,
                      attendance=attendance, odds_id=new_odds.odds_id)
    db.session.add(new_match)
    db.session.commit()
    return new_match


def getAllMatches():
    return Match.query.all()


def getMatch(match_id):
    return Match.query.get_or_404(match_id)


def updateMatch(match_id):
    match = getMatch(match_id)
    match.ref = request.form['ref']
    match.game_date = datetime.strptime(request.form['game_date'], '%Y-%m-%d')
    match.venue = request.form['venue']
    match.home = request.form['home']
    match.away = request.form['away']
    match.scoreline = request.form['scoreline']
    match.attendance = request.form['attendance']

    # Update the odds object
    odds = Odds.query.get_or_404(match.odds_id)
    odds.under_odds = request.form['under_odds']
    odds.over_odds = request.form['over_odds']
    
    db.session.commit()
    return match


def deleteMatch(match_id):
    match = getMatch(match_id)
    db.session.delete(match)
    db.session.commit()
