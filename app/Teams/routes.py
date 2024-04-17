from flask import render_template, Blueprint, redirect, url_for
import app.Teams.dao as team_dao
app = Blueprint('teams', __name__)

@app.route('/teams')
def show_teams():
    try:
        all_teams = team_dao.getAllTeams()
        return render_template('Teams/teams.html', teams=all_teams)
    except Exception as e:
        return render_template('Components/errors.html', error_message=str(e))
    
@app.route('/teams/<team_name>')
def team_details(team_name):
    print(team_name)
    try:
        team = team_dao.getTeam(team_name)
        return render_template('Teams/team_details.html', team=team)
    except Exception as e:
        return render_template('Components/errors.html', error_message=str(e))

@app.route('/teams/edit/<team_name>')
def team_edit(team_name):
    try:
        team = team_dao.getTeam(team_name)
        return render_template('Teams/team_edit.html', team=team)
    except Exception as e:
        return render_template('Components/errors.html', error_message=str(e))

@app.route('/update_team/<t_name>', methods=['POST'])
def update_team(t_name):
    try:
        team_dao.updateTeam(t_name)
        return redirect(url_for('teams.show_teams'))
    except Exception as e:
        return render_template('Components/errors.html', error_message=str(e))

@app.route('/add_team', methods=['POST'])
def add_team():
    try:
        team_dao.createTeam()
        return redirect(url_for('teams.show_teams'))
    except Exception as e:
        return render_template('Components/errors.html', error_message=str(e))
    
@app.route('/delete_team/<t_name>', methods=['POST'])
def delete_team(t_name):
    try:
        team_dao.deleteTeam(t_name)
        return redirect(url_for('teams.show_teams'))
    except Exception as e:
        return render_template('Components/errors.html', error_message=str(e))