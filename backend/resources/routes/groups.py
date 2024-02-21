from flask import request
from json import loads
from resources import app
from resources.queries import getAllGroups

@app.get('/getGroups')
async def getGroups():
    try:
        output = await getAllGroups()
        return output

    except Exception as e:
        print('Ошибка: ', e)