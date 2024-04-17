from flask import render_template, Blueprint, redirect, url_for
import app.Referees.dao as referee_dao
app = Blueprint('referees', __name__)

@app.route('/referees')
def show_referees():
    try:
        all_referees = referee_dao.getAllReferees()
        return render_template('Referees/referees.html', referees=all_referees)
    except Exception as e:
        return render_template('Components/errors.html', error_message=str(e))
    
@app.route('/referees/<int:ref_id>')
def referee_details(ref_id):
    try:
        referee = referee_dao.getReferee(ref_id)
        return render_template('Referees/referee_details.html', referee=referee)
    except Exception as e:
        return render_template('Components/errors.html', error_message=str(e))
    
@app.route('/referees/edit/<int:ref_id>')
def referee_edit(ref_id):
    try:
        referee = referee_dao.getReferee(ref_id)
        return render_template('Referees/referee_edit.html', referee=referee)
    except Exception as e:
        return render_template('Components/errors.html', error_message=str(e))

@app.route('/update_referee/<int:ref_id>', methods=['POST'])
def update_referee(ref_id):
    try:
        referee_dao.updateReferee(ref_id)
        return redirect(url_for('referees.show_referees'))
    except Exception as e:
        return render_template('Components/errors.html', error_message=str(e))

@app.route('/add_referee', methods=['POST'])
def add_referee():
    try:
        referee_dao.createReferee()
        return redirect(url_for('referees.show_referees'))
    except Exception as e:
        return render_template('Components/errors.html', error_message=str(e))
    
@app.route('/delete_referee/<int:ref_id>', methods=['POST'])
def delete_referee(ref_id):
    try:
        referee_dao.deleteReferee(ref_id)
        return redirect(url_for('referees.show_referees'))
    except Exception as e:
        return render_template('Components/errors.html', error_message=str(e))