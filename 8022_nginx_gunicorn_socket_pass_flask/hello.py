from flask import Flask
from flask_restful import Api
from flask_restful import Resource


class HelloWorld(Resource):
    def get(self):
        return {'message': 'Hello World'}


app = Flask(__name__)
api = Api(app)
api.add_resource(HelloWorld, '/')
