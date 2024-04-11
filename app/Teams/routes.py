from flask import render_template, Blueprint, redirect, url_for
import app.Teams.dao as team_dao
app = Blueprint('teams', __name__)

@app.route('/teams')
def show_teams():
    try:
        all_teams = team_dao.getAllTeams()
        return render_template('Teams/teams.html', teams=all_teams)
    except Exception as e:
        return str(e)
    
@app.route('/teams/<team_id>')
def team_details(team_id):
    try:
        team = team_dao.getTeam(team_id)
        return render_template('Managers/manager_details.html', team=team)
    except Exception as e:
        return str(e)

@app.route('/update_team/<team_id>', methods=['POST'])
def update_team(team_id):
    try:
        team_dao.updateTeam(team_id)
        return redirect(url_for('teams.show_teams'))
    except Exception as e:
        return str(e)

@app.route('/add_team', methods=['POST'])
def add_team():
    try:
        team_dao.createTeam()
        return redirect(url_for('teams.show_teams'))
    except Exception as e:
        return str(e)
    
@app.route('/delete_team/<team_id>', methods=['POST'])
def delete_match(team_id):
    try:
        team_dao.deleteTeam(team_id)
        return redirect(url_for('teams.show_teams'))
    except Exception as e:
        return str(e)