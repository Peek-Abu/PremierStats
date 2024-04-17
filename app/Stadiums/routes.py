from flask import render_template, Blueprint, redirect, url_for
import app.Stadiums.dao as stadium_dao
app = Blueprint('stadiums', __name__)

@app.route('/stadiums')
def show_stadiums():
    try:
        all_stadiums = stadium_dao.getAllStadiums()
        return render_template('Stadiums/stadiums.html', stadiums=all_stadiums)
    except Exception as e:
        return render_template('Components/errors.html', error_message=str(e))
    
@app.route('/stadiums/<int:stadium_id>')
def stadium_details(stadium_id):
    try:
        stadium = stadium_dao.getStadium(stadium_id)
        return render_template('Stadiums/stadium_details.html', stadium=stadium)
    except Exception as e:
        return render_template('Components/errors.html', error_message=str(e))

@app.route('/stadiums/edit/<int:stadium_id>')
def stadium_edit(stadium_id):
    try:
        stadium = stadium_dao.getStadium(stadium_id)
        return render_template('Stadiums/stadium_edit.html', stadium=stadium)
    except Exception as e:
        return render_template('Components/errors.html', error_message=str(e))

@app.route('/update_stadium/<int:stadium_id>', methods=['POST'])
def update_stadium(stadium_id):
    try:
        stadium_dao.updateStadium(stadium_id)
        return redirect(url_for('stadiums.show_stadiums'))
    except Exception as e:
        return render_template('Components/errors.html', error_message=str(e))

@app.route('/add_stadium', methods=['POST'])
def add_stadium():
    try:
        stadium_dao.createStadium()
        return redirect(url_for('stadiums.show_stadiums'))
    except Exception as e:
        return render_template('Components/errors.html', error_message=str(e))
    
@app.route('/delete_stadium/<int:stadium_id>', methods=['POST'])
def delete_stadium(stadium_id):
    try:
        stadium_dao.deleteStadium(stadium_id)
        return redirect(url_for('stadiums.show_stadiums'))
    except Exception as e:
        return render_template('Components/errors.html', error_message=str(e))