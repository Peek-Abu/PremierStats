from flask import render_template, Blueprint, redirect, url_for
import app.Managers.dao as manager_dao
app = Blueprint('managers', __name__)

@app.route('/managers')
def show_managers():
    try:
        all_managers = manager_dao.get_all_managers()
        return render_template('Managers/managers.html', managers=all_managers)
    except Exception as e:
        return str(e)

@app.route('/managers/<int:manager_id>')
def manager_details(manager_id):
    try:
        manager = manager_dao.get_manager(manager_id)
        return render_template('Managers/manager_details.html', manager=manager)
    except Exception as e:
        return str(e)

@app.route('/managers/edit/<int:manager_id>')
def manager_edit(manager_id):
    try:
        manager = manager_dao.get_manager(manager_id)
        return render_template('Managers/manager_edit.html', manager=manager)
    except Exception as e:
        return str(e)

@app.route('/update_manager/<int:manager_id>', methods=['POST'])
def update_manager(manager_id):
    try:
        manager_dao.update_manager(manager_id)
        return redirect(url_for('managers.show_managers'))
    except Exception as e:
        return str(e)

@app.route('/add_manager', methods=['POST'])
def add_manager():
    try:
        manager_dao.create_manager()
        return redirect(url_for('managers.show_managers'))
    except Exception as e:
        return str(e)
    
@app.route('/delete_manager/<int:manager_id>', methods=['POST'])
def delete_manager(manager_id):
    print(manager_id)
    try:
        manager_dao.delete_manager(manager_id)
        return redirect(url_for('managers.show_managers'))
    except Exception as e:
        return str(e)