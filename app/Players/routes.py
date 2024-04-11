from flask import render_template, Blueprint, redirect, url_for
import app.Players.dao as player_dao
app = Blueprint('players', __name__)

@app.route('/players')
def show_players():
    try:
        all_players = player_dao.getAllPlayers()
        return render_template('players.html', players=all_players)
    except Exception as e:
        return str(e)
    
@app.route('/players/<int:player_id>')
def player_details(player_id):
    try:
        player = player_dao.getPlayer(player_id)
        return render_template('Managers/manager_details.html', player=player)
    except Exception as e:
        return str(e)

@app.route('/update_player/<int:player_id>', methods=['POST'])
def update_player(player_id):
    try:
        player_dao.updatePlayer(player_id)
        return redirect(url_for('players.show_players'))
    except Exception as e:
        return str(e)

@app.route('/add_player', methods=['POST'])
def add_player():
    try:
        player_dao.createPlayer()
        return redirect(url_for('players.show_players'))
    except Exception as e:
        return str(e)
    
@app.route('/delete_player/<int:player_id>', methods=['POST'])
def delete_player(player_id):
    try:
        player_dao.deletePlayer(player_id)
        return redirect(url_for('players.show_players'))
    except Exception as e:
        return str(e)