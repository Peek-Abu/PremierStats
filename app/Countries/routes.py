from flask import render_template, Blueprint, redirect, url_for
import app.Countries.dao as country_dao
app = Blueprint('countries', __name__)

@app.route('/countries')
def show_countries():
    try:
        all_countries = country_dao.getAllCountries()
        return render_template('Countries/countries.html', countries=all_countries)
    except Exception as e:
        return str(e)
    
@app.route('/countries/<string:c_name>')
def country_details(c_name):
    try:
        country = country_dao.getCountry(c_name)
        return render_template('Countries/country_details.html', country=country)
    except Exception as e:
        return str(e)

@app.route('/countries/edit/<string:c_name>')
def country_edit(c_name):
    try:
        country = country_dao.getCountry(c_name)
        return render_template('Countries/country_edit.html', country=country)
    except Exception as e:
        return str(e)

@app.route('/update_country/<string:c_name>', methods=['POST'])
def update_country(c_name):
    try:
        country_dao.updateCountry(c_name)
        return redirect(url_for('countries.show_countries'))
    except Exception as e:
        return str(e)

@app.route('/add_country', methods=['POST'])
def add_country():
    try:
        country_dao.createCountry()
        return redirect(url_for('countries.show_countries'))
    except Exception as e:
        return str(e)
    
@app.route('/delete_country/<string:c_name>', methods=['POST'])
def delete_country(c_name):
    try:
        country_dao.deleteCountry(c_name)
        return redirect(url_for('countries.show_countries'))
    except Exception as e:
        return str(e)