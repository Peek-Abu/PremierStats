from flask import render_template, Blueprint, redirect, url_for
import app.Odds.dao as odds_dao
app = Blueprint('odds', __name__)

# @app.route('/odds')
# def show_odds():
#     try:
#         all_odds = odds_dao.getAllOdds()
#         return render_template('Odds/odds.html', odds=all_odds)
#     except Exception as e:
#         return str(e)
    
# @app.route('/odds/<int:odds_id>')
# def odds_details(odds_id):
#     try:
#         odd = odds_dao.getOdds(odds_id)
#         return render_template('Odds/odds_details.html', odds=odd)
#     except Exception as e:
#         return str(e)
    
# @app.route('/odds/edit/<int:odds_id>')
# def odds_edit(odds_id):
#     try:
#         odd = odds_dao.getOdds(odds_id)
#         return render_template('Odds/odds_edit.html', odds=odd)
#     except Exception as e:
#         return str(e)

# @app.route('/update_odds/<int:odds_id>', methods=['POST'])
# def update_odds(odds_id):
#     try:
#         odds_dao.updateOdds(odds_id)
#         return redirect(url_for('odds.show_odds'))
#     except Exception as e:
#         return str(e)

# @app.route('/add_odds', methods=['POST'])
# def add_odds():
#     try:
#         odds_dao.createOdds()
#         return redirect(url_for('odds.show_odds'))
#     except Exception as e:
#         return str(e)
    
# @app.route('/delete_odds/<int:odds_id>', methods=['POST'])
# def delete_odds(odds_id):
#     try:
#         odds_dao.deleteOdds(odds_id)
#         return redirect(url_for('odds.show_odds'))
#     except Exception as e:
#         return str(e)