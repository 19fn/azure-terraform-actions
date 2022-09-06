from flask import Flask
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__, template_folder="templates")

# SENSIBLE
server_name = "mysql-server-devtest-eu01.mysql.database.azure.com"
database_name = "devtest"
server_admin_login_name = "fnc1_admin@mysql-server-devtest-eu01"
server_admin_login_password = "bKS1s4X7Sb9hdOGP"

# Database string connection
app.config["SQLALCHEMY_DATABASE_URI"] = f"mysql+pymysql://{server_admin_login_name}:{server_admin_login_password}@{server_name}:3306/{database_name}"
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config["SECRET_KEY"] = "byiqpj0nZpJ+GnkPEFx86A=="

# SQLAlchemy
db = SQLAlchemy(app)

from web import routes