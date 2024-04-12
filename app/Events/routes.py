from flask import render_template, Blueprint, redirect, url_for
import app.Events.dao as event_dao
app = Blueprint('events', __name__)

@app.route('/events')
def show_events():
    try:
        all_events = event_dao.getAllEvents()
        return render_template('events.html', events=all_events)
    except Exception as e:
        return str(e)
    
@app.route('/events/<int:event_id>')
def event_details(event_id):
    try:
        event = event_dao.getEvent(event_id)
        return render_template('Managers/manager_details.html', event=event)
    except Exception as e:
        return str(e)

@app.route('/update_event/<int:event_id>', methods=['POST'])
def update_event(event_id):
    try:
        event_dao.updateEvent(event_id)
        return redirect(url_for('events.show_events'))
    except Exception as e:
        return str(e)

@app.route('/add_event', methods=['POST'])
def add_event():
    try:
        event_dao.createEvent()
        return redirect(url_for('events.show_events'))
    except Exception as e:
        return str(e)
    
@app.route('/delete_event/<int:event_id>', methods=['POST'])
def delete_event(event_id):
    try:
        event_dao.deleteEvent(event_id)
        return redirect(url_for('events.show_events'))
    except Exception as e:
        return str(e)