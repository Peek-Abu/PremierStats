from flask import render_template, Blueprint, redirect, url_for
import app.Matches.dao as match_dao
app = Blueprint('matches', __name__)

@app.route('/matches')
def show_matches():
    try:
        all_matches = match_dao.getAllMatches()
        return render_template('Matches/matches.html', matches=all_matches)
    except Exception as e:
        return render_template('Components/errors.html', error_message=str(e))
    
@app.route('/matches/<int:match_id>')
def match_details(match_id):
    try:
        print(match_id)
        match = match_dao.getMatch(match_id)
        print(match)
        return render_template('Matches/match_details.html', match=match)
    except Exception as e:
        return render_template('Components/errors.html', error_message=str(e))

@app.route('/matches/edit/<int:match_id>')
def match_edit(match_id):
    try:
        match = match_dao.getMatch(match_id)
        return render_template('Matches/match_edit.html', match=match)
    except Exception as e:
        return render_template('Components/errors.html', error_message=str(e))

@app.route('/update_match/<int:match_id>', methods=['POST'])
def update_match(match_id):
    try:
        match_dao.updateMatch(match_id)
        return redirect(url_for('matches.show_matches'))
    except Exception as e:
        return render_template('Components/errors.html', error_message=str(e))

@app.route('/add_match', methods=['POST'])
def add_match():
    try:
        match_dao.createMatch()
        return redirect(url_for('matches.show_matches'))
    except Exception as e:
        return render_template('Components/errors.html', error_message=str(e))
    
@app.route('/delete_match/<int:match_id>', methods=['POST'])
def delete_match(match_id):
    try:
        match_dao.deleteMatch(match_id)
        return redirect(url_for('matches.show_matches'))
    except Exception as e:
        return render_template('Components/errors.html', error_message=str(e))