from flask import render_template, Blueprint, redirect, url_for
import app.Assists.dao as assist_dao
app = Blueprint('assists', __name__)

@app.route('/assists')
def show_assists():
    try:
        all_assists = assist_dao.getAllAssists()
        return render_template('Assists/assists.html', assists=all_assists)
    except Exception as e:
        return render_template('Components/errors.html', error_message=str(e))

@app.route('/assists/<int:assist_id>')
def assist_details(assist_id):
    try:
        assist = assist_dao.getAssist(assist_id)
        return render_template('Assists/assist_details.html', assist=assist)
    except Exception as e:
        return render_template('Components/errors.html', error_message=str(e))

@app.route('/assists/edit/<int:assist_id>')
def assist_edit(assist_id):
    try:
        assist = assist_dao.getAssist(assist_id)
        return render_template('Assists/assist_edit.html', assist=assist)
    except Exception as e:
        return render_template('Components/errors.html', error_message=str(e))

@app.route('/update_assist/<int:assist_id>', methods=['POST'])
def update_assist(assist_id):
    try:
        assist_dao.updateAssist(assist_id)
        return redirect(url_for('assists.show_assists'))
    except Exception as e:
        return render_template('Components/errors.html', error_message=str(e))

@app.route('/add_assist', methods=['POST'])
def add_assist():
    try:
        assist_dao.createAssist()
        return redirect(url_for('assists.show_assists'))
    except Exception as e:
        return render_template('Components/errors.html', error_message=str(e))
    
@app.route('/delete_assist/<int:assist_id>', methods=['POST'])
def delete_assist(assist_id):
    try:
        assist_dao.deleteAssist(assist_id)
        return redirect(url_for('assists.show_assists'))
    except Exception as e:
        return render_template('Components/errors.html', error_message=str(e))