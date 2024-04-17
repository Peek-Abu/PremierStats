from flask import Flask, render_template
from app.database import db
from app.commands import seed_db, reset_db, seed_csv_data

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///yourdatabase.db'
db.init_app(app)

with app.app_context():
    db.create_all()


from app.Managers.routes import app as managers_routes
from app.Assists.routes import app as assists_routes
from app.Events.routes import app as events_routes
from app.Teams.routes import app as teams_routes
from app.Players.routes import app as players_routes
from app.Matches.routes import app as matches_routes
from app.Countries.routes import app as countries_routes
from app.Referees.routes import app as referees_routes
from app.Stadiums.routes import app as stadiums_routes
from app.Odds.routes import app as odds_routes
from app.Stats.routes import app as stats_routes
from app.Leagues.routes import app as league_routes
app.register_blueprint(managers_routes)
app.register_blueprint(assists_routes)
app.register_blueprint(events_routes)
app.register_blueprint(teams_routes)
app.register_blueprint(players_routes)
app.register_blueprint(matches_routes)
app.register_blueprint(countries_routes)
app.register_blueprint(referees_routes)
app.register_blueprint(stadiums_routes)
app.register_blueprint(odds_routes)
app.register_blueprint(stats_routes)
app.register_blueprint(league_routes)
app.cli.add_command(seed_db)
app.cli.add_command(reset_db)
app.cli.add_command(seed_csv_data)

@app.route('/', methods=['GET'])
def HomePage():
    return render_template('Home/home.html')
