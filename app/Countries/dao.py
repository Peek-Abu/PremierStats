from flask import request
from app.database import db
from app.models import Country


def createCountry():
    c_name = request.form['c_name']
    leagues_hosted = request.form['leagues_hosted']

    new_country = Country(c_name=c_name, leagues_hosted=leagues_hosted)
    db.session.add(new_country)
    db.session.commit()
    return new_country


def getAllCountries():
    return Country.query.all()


def getCountry(c_name):
    return Country.query.get_or_404(c_name)


def updateCountry(c_name):
    country = getCountry(c_name)
    country.c_name = request.form['c_name']
    country.leagues_hosted = request.form['leagues_hosted']
    db.session.commit()
    return country


def deleteCountry(c_name):
    country = getCountry(c_name)
    db.session.delete(country)
    db.session.commit()
