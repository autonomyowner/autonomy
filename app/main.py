Creating such a comprehensive system would be quite a large task to demonstrate in this chat interface. However, I can provide you with some high-level guidance on how you might structure your Flask backend code, as well as the necessary PostgreSQL commands for creating tables and user login functionality. 

Here is an outline of how you could start building it:

1. Set up a new Flask application:
```python
from flask import Flask, request, jsonify
app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Hello World!'

if __name__ == '__main__':
    app.run(debug=True)
```

2. Install necessary packages:
- `flask`
- `flask_sqlalchemy`
- `flask_login`
- `psycopg2` (for PostgreSQL connection)

3. Configure your PostgreSQL database using Flask SQLAlchemy, install `flask_sqlalchemy` if not already installed:
```python
from flask_sqlalchemy import SQLAlchemy
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://username:password@localhost/dbname'
db = SQLAlchemy(app)
```

4. Create your models (tables):
```python
class User(UserMixin, db.Model):
    id = db.Column(db.Integer, primary_key=True) 
    username = db.Column(db.String(64), unique=True, index=True)
    # ...other fields...
    
class Field(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(64))
    # ...other fields...
```

5. Create your routes:
- User Login:
```python
from flask_login import login_user, logout_user, login_required
@app.route('/login', methods=['POST'])
def login():
    data = request.get_json()  # assuming json payload with username and password
    user = User.query.filter_by(username=data.get('username')).first()
    if user and user.check_password(data.get('password')):
        login_user(user)
        return jsonify({"status": "success"})
    return jsonify({"status": "failure", "message": "Invalid username or password."})
```
- User Logout:
```python
@app.route('/logout')
@login_required
def logout():
    logout_user()
    return jsonify({"status": "success"})
```
- Field Tracking:
```python
@app.route('/field', methods=['POST'])
@login_required
def add_field():
    data = request.get_json()  # assuming json payload with field details
    field = Field(**data)
    db.session.add(field)
    db.session.commit()
    return jsonify({"status": "success", "message": "Field added successfully."})
```
6. Satellite data integration is a broad topic and depends heavily on the specific satellite data you're working with, so I can't provide detailed code for it here. You might want to look into using APIs provided by satellite companies like Planet or NASA's Open Data APIs to pull in real-time satellite data.

7. Docker + GitHub Actions:
Dockerizing your Flask application and setting up CI/CD pipelines using GitHub Actions can be done according to the official documentation. You will need a `Dockerfile`, `requirements.txt` file for dependencies, `.dockerignore` file, and GitHub actions workflow yml files.

Please note that this is a very high-level guide and actual implementation may vary based on specific requirements of your SaaS platform. Also remember to handle sensitive information like passwords securely in production environment.


