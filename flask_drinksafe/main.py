from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
from flask_marshmallow import Marshmallow
import os

app = Flask(__name__)
basedir = os.path.abspath(os.path.dirname(__file__))

app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///' + os.path.join(basedir, 'db.sqlite')


# suppress SQLALCHEMY_TRACK_MODIFICATIONS warning
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)
ma = Marshmallow(app)

class DrinkEntry(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    drink = db.Column(db.String(100))
    amt = db.Column(db.Double)

    def __init__(self, drink, amt):
        self.drink = drink
        self.amt = amt

# Todo schema
class DrinkSchema(ma.Schema):
    class Meta:
        fields = ('id', 'drink', 'amt')

# Initialize schema
drink_schema = DrinkSchema()
drinks_schema =DrinkSchema(many=True)

# To create database:
# from main import app, db
# app.app_context().push()
# db.create_all()
# exit()

@app.route('/drink', methods=['POST'])
def add_drink():
    drink = request.json['drink']
    amt = request.json['amt']

    new_drink_entry = DrinkEntry(drink, amt)
    db.session.add(new_drink_entry)
    db.session.commit()

    return drink_schema.jsonify(new_drink_entry)

@app.route('/drink', methods=['GET'])
def get_drinks():
    all_drinks = DrinkEntry.query.all()
    result = drinks_schema.dump(all_drinks)

    return jsonify(result)

@app.route('/drink/<id>', methods=['PUT', 'PATCH'])
def increment_drink(id):
    drink = DrinkEntry.query.get(id)
    drink.amt += 1
    db.session.commit()

    return drink_schema.jsonify(drink)

@app.route('/drink/<id>', methods=['DELETE'])
def delete_drink(id):
    drink_to_delete = DrinkEntry.query.get(id)
    db.session.delete(drink_to_delete)
    db.session.commit()

    return drink_schema.jsonify(drink_to_delete)

if __name__ == '__main__':
    app.run(debug=True)