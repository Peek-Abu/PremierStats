from flask import render_template, Blueprint, redirect, url_for
import app.Leagues.dao as league_dao
app = Blueprint('leagues', __name__)

@app.route('/leagues')
def show_leagues():
    try:
        all_leagues = league_dao.getAllLeagues()
        return render_template('Leagues/leagues.html', leagues=all_leagues)
    except Exception as e:
        return str(e)
    
@app.route('/leagues/<string:league_name>')
def league_details(league_name):
    try:
        league = league_dao.getLeague(league_name)
        return render_template('Leagues/league_details.html', league=league)
    except Exception as e:
        return str(e)

@app.route('/leagues/edit/<string:league_name>')
def league_edit(league_name):
    try:
        league = league_dao.getLeague(league_name)
        return render_template('Leagues/league_edit.html', league=league)
    except Exception as e:
        return str(e)

@app.route('/update_league/<string:league_name>', methods=['POST'])
def update_league(league_name):
    try:
        league_dao.updateLeague(league_name)
        return redirect(url_for('leagues.show_leagues'))
    except Exception as e:
        return str(e)

@app.route('/add_league', methods=['POST'])
def add_league():
    try:
        league_dao.createLeague()
        return redirect(url_for('leagues.show_leagues'))
    except Exception as e:
        return str(e)
    
@app.route('/delete_league/<string:league_name>', methods=['POST'])
def delete_league(league_name):
    try:
        league_dao.deleteLeague(league_name)
        return redirect(url_for('leagues.show_leagues'))
    except Exception as e:
        return str(e)