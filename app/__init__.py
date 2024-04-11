from flask import Flask, render_template
from app.database import db
from app.commands import seed_db, reset_db

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
app.register_blueprint(managers_routes)
app.register_blueprint(assists_routes)
app.register_blueprint(events_routes)
app.register_blueprint(teams_routes)
app.register_blueprint(players_routes)
app.register_blueprint(matches_routes)
app.cli.add_command(seed_db)
app.cli.add_command(reset_db)

@app.route('/', methods=['GET'])
def HomePage():
    return render_template('Home/home.html')
