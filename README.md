# PremierStats

TLDR:
    flask reset_db # Reset DB

    flask seed_csv_data # Import CSV data

    pip install -r requirements.txt # Install requirements

    flask run # Start the application

1. Accessing the Application
   - Install all the dependencies: pip install -r requirements.txt
   - run the command: flask run. 
   -  The website should be served on your localhost on port 5000 (Default port for flask).
2. Logging In
   - Upon accessing the application, the user will be prompted to enter their username and password for database authentication.

3. Navigating through Navigation Bar Options
   - After successful login, the user will be directed to the homepage (Home) of the application.
   - The navigation bar will display 11 options: Home, Countries, Managers, Referees, Stadiums, Teams, Matches, Players, Events, Stadiums, and League.

4. Viewing Countries
   - Click on Countries in the navigation bar.
   - View a list of all countries stored in the database.
   - Click on the eye icon next to a country to view specific details.

5. Managing Managers
   - Click on Managers in the navigation bar.
   - Add a new manager by filling out the manager details form.
   - View a list of all managers added so far.
   - Click on a manager's name to view detailed information.
    - Edit information regarding the manager by clicking on the pencil icon next to the manager

6. Handling Referees
   - Click on Referees in the navigation bar.
   - Add new referees using the provided form.
   - View a list of all referees stored in the database.
   - Click on a referee's name to view detailed information.
    - Edit information regarding the referees by clicking on the pencil icon next to the referees
7. Managing Stadiums
    - Click on Fields in the navigation bar.
    - Add new stadiums used for matches.
    - View a list of all available fields.
    - Click on the eye icon next to a stadium to view detailed information.
    - Edit information regarding the stadium by clicking on the pencil icon next to the stadium

8. Managing Teams
   - Click on Teams in the navigation bar.
   - Add new sports teams using the team details form.
   - View a list of all teams available.
   - Click on a team's name to view detailed information.
    - Edit information regarding the team by clicking on the pencil icon next to the team

9. Handling Matches
   - Click on Matches in the navigation bar.
   - Add new matches by entering match details.
   - View a list of all scheduled matches.
   - Click on a match to view detailed information 
    - Edit information regarding the match by clicking on the pencil icon next to the match

10. Managing Players
    - Click on Players in the navigation bar.
    - Add new players to the database.
    - View a list of all players.
    - Click on a player's name to view detailed player information.
    - Edit information regarding the player by clicking on the pencil icon next to the player


11. Handling Events
    - Click on Events in the navigation bar.
    - Add new events by entering event details.
    - View a list of all upcoming events.
    - Click on an event to view detailed information.
    - Edit information regarding the events by clicking on the pencil icon next to the event

12. Managing Leagues
    - Click on League in the navigation bar.
    - Add new leagues by entering league details.
    - View a list of all leagues stored in the database.
    - Click on the eye icon next to a league next to the player to view detailed information.
    - Edit information regarding the league by clicking on the pencil icon next to the league
13. Data extraction from a CSV
    Enter the command:flask seed_csv_data
