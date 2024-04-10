from flask import Flask
from app.database import db
from app.commands import seed_db, reset_db
def create_app():
    app = Flask(__name__)
    app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///yourdatabase.db'

    db.init_app(app)

    with app.app_context():
        db.create_all()

    from app.routes import app as main_blueprint
    app.register_blueprint(main_blueprint)
    app.cli.add_command(seed_db)
    app.cli.add_command(reset_db)

    return app
