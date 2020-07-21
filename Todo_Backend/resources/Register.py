from flask_restful import Resource
from flask import request
from Model import db, User
import random
import string
# import json

class Register(Resource):

    def get(self):
        users = User.query.all()
        # users = users.dump(users).data
        user_list=[]
        for i in range(0,len(users)):
            user_list.append(users[i].serialize())

        return {"status": str(user_list)},200


    def post(self):
        # print(request.get_json())\
        json_data = request.get_json(force=True)

        if not json_data:
            return {'message': 'No input data provided'}, 400

        # data , errors = User.load(json_data)
        # if errors:
        #     return errors, 422

        user = User.query.filter_by(username=json_data['username']).first()
        if user:
            return {'message': 'Username already exists'}, 400

        user = User.query.filter_by(emailadress=json_data['emailadress']).first()
        if user:
            return {'message': 'Email address already exists'}, 400
        
        api_key = self.generate_key()
        user = User.query.filter_by(api_key=api_key).first()
        
        if user:
            return {'message': 'Api key already exists'}, 400

        user= User(
            api_key = api_key,
            firstname = json_data["firstname"],
            lastname = json_data["lastname"],
            emailadress = json_data["emailadress"],
            password = json_data["password"],
            username = json_data["username"],
        )
        db.session.add(user) 
        db.session.commit()

        result = User.serialize(user)

        return { "status":"success", "data":result}

    def generate_key(self):
        return ''.join(random.choice(string.ascii_letters+string.digits) for _ in range(50))
        # username = data['username']
        # password = data['password']
        # emailadress = data['emailadress']
        # print(data['username'])
        # print(data['password'])
        # print(data['emailadress'])
        # return {"message":"Registering {}".format(username)}

        