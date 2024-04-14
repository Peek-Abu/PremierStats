from flask import render_template, Blueprint, redirect, url_for
import app.Stats.dao as stats_dao
app = Blueprint('stats', __name__)

@app.route('/stats')
def show_stats():
    try:
        all_stats = stats_dao.getAllStats()
        return render_template('Stats/stats.html', stats=all_stats)
    except Exception as e:
        return str(e)
    
@app.route('/stats/<int:stats_id>')
def stats_details(stats_id):
    try:
        stat = stats_dao.getStats(stats_id)
        return render_template('Stats/stats_details.html', stat=stat)
    except Exception as e:
        return str(e)

@app.route('/stats/edit/<int:stats_id>')
def stats_edit(stats_id):
    try:
        stat = stats_dao.getStats(stats_id)
        return render_template('Stats/stats_edit.html', stat=stat)
    except Exception as e:
        return str(e)

@app.route('/update_stats/<int:stats_id>', methods=['POST'])
def update_stats(stats_id):
    try:
        stats_dao.updateStats(stats_id)
        return redirect(url_for('stats.show_stats'))
    except Exception as e:
        return str(e)

@app.route('/add_stats', methods=['POST'])
def add_stats():
    try:
        stats_dao.createStats()
        return redirect(url_for('stats.show_stats'))
    except Exception as e:
        return str(e)
    
@app.route('/delete_stats/<int:stats_id>', methods=['POST'])
def delete_stats(stats_id):
    try:
        stats_dao.deleteStats(stats_id)
        return redirect(url_for('stats.show_stats'))
    except Exception as e:
        return str(e)