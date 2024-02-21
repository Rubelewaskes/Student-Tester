from flask import request
from json import loads
from resources import app
from resources.queries import getTableResults
from resources.queries import getColumns
from resources.queries import getTableResultsStud
from resources.queries import findAnswers

@app.get('/columns')
async def columns():
    try:
        test_id = request.args['test_id']
        output = await getColumns(test_id)
        return output

    except Exception as e:
        print('Ошибка: ', e)
        
@app.get('/findAnswers')
async def answers():
    try:
        token = request.args['token']
        test_id = request.args['test_id']
        output = await findAnswers(test_id, token)
        return output

    except Exception as e:
        print('Ошибка: ', e)

@app.get('/tableResults')
async def tableResults():
    try:
        test_id = request.args['test_id']
        output = await getTableResults(test_id)
        
        return output

    except Exception as e:
        print('Ошибка: ', e)

@app.get('/tableResultsStud')
async def tableResultsStud():
    try:
        test_id = request.args['test_id']
        token = request.args['token']
        output = await getTableResultsStud(test_id, token)
        
        return output

    except Exception as e:
        print('Ошибка: ', e)