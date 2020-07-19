import os

basedir= os.path.abspath(os.path.dirname(__file__))
SQLALCHEMY_ECHO= False
SQLALCHEMY_TRACK_MODIFICATION= True
SQLALCHEMY_DATABASE_URI="postgresql://username:password@localhost/TodoApp_Db"