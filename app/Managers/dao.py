from flask import request
from app.models import Manager
from app.database import db

def create_manager():
    new_manager = Manager(name=request.form['name'], 
                            age=request.form['age'],
                            years_managing=request.form['years_managing'], 
                            titles_managed=request.form['titles_managed'])
    db.session.add(new_manager)
    db.session.commit()

def get_all_managers():
    return Manager.query.all()

def get_manager(manager_id):
    return Manager.query.get_or_404(manager_id)

def update_manager(manager_id):
    manager = Manager.query.get_or_404(manager_id)
    manager.name = request.form['name']
    manager.age = request.form['age']
    manager.years_managing = request.form['years_managing']
    manager.titles_managed = request.form['titles_managed']
    db.session.commit()

def delete_manager(manager_id):
    print(manager_id)
    manager = Manager.query.get_or_404(manager_id)
    db.session.delete(manager)
    db.session.commit()