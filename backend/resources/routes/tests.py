from flask import request
from json import loads
from resources import app

from resources.queries import check_user
from resources.queries import getStudentTests
from resources.queries import getTeacherTests
from resources.queries import getAllTests
from resources.queries import getQuestions
from resources.queries import getNameTest
from resources.queries import postAnswer
from resources.queries import createTest
from resources.queries import getFullTestInfo
from resources.queries import drop
from resources.queries import update


@app.get('/testsStudent')
async def testStudent():
    try:
        if await check_user(request.args['login']) == 'student':
            group_id = request.args['group_id']
            output = await getStudentTests(group_id)
            return output
        else:
            raise ValueError('Нет прав!')

    except ValueError as e:
        print("Ошибка: ", e)
    except Exception as e:
        print('Ошибка: ', e)
    


@app.get('/testsTeacher')
async def testTeacher():
    try:
        if await check_user(request.args['login']) == 'teacher':
            teacher_id = request.args['token']
            output = await getTeacherTests(teacher_id)
            return output
        else:
            raise ValueError('Нет прав!')

    except ValueError as e:
        print("Ошибка: ", e)
    except Exception as e:
        print('Ошибка: ', e)
    


@app.get('/testsAdmin')
async def testAdmin():
    try:
        if await check_user(request.args['login']) == 'admin':
            output = await getAllTests()
            return output
        else:
            raise ValueError('Нет прав!')

    except ValueError as e:
        print("Ошибка: ", e)
    except Exception as e:
        print('Ошибка: ', e)
    

@app.get('/getTest')
async def getTest():
    try:
        if request.args['login']:
            test_id = request.args['test_id']
            output = await getQuestions(test_id)
            return output

        else:
            raise ValueError('Нет прав!')
    
    except ValueError as e:
        print("Ошибка: ", e)
    except Exception as e:
        print('Ошибка: ', e)
    
    

@app.get('/getNameTest')
async def getName():
    try:
        if request.args['login']:
            test_id = request.args['test_id']
            output = await getNameTest(test_id)
            return output
        else:
            raise ValueError('Нет прав!')

    except ValueError as e:
        print("Ошибка: ", e)
    except Exception as e:
        print('Ошибка: ', e)
    

@app.post('/postAnswers')
async def postAnswers():
    try:
        data = request.data.decode('utf8')
        if await check_user(loads(data)[0]['login']) == 'student':
            output = {'exit':await postAnswer(loads(data))}
            return output
        else:
            raise ValueError('Нет прав!')

    except ValueError as e:
        print("Ошибка: ", e)
    except Exception as e:
        print('Ошибка: ', e)
    

@app.post('/postTest')
async def postTest():
    try:
        data = request.data.decode('utf8')
        if await check_user(loads(data)['login']) == 'teacher':
            output = {'exit': await createTest(loads(data))}
            return output
        else:
            raise ValueError('Нет прав!')

    except ValueError as e:
        print("Ошибка: ", e)
        return e
    except Exception as e:
        print('Ошибка: ', e)
    

@app.get('/getFullTest')
async def getFullTest():
    try:
        if await check_user(request.args['login']) == 'admin':
            output = await getFullTestInfo(request.args['test_id'])
            return output
        else:
            raise ValueError('Нет прав!')  

    except ValueError as e:
        print("Ошибка: ", e)
        return e
    except Exception as e:
        print('Ошибка: ', e)
    

@app.post('/updateTest')
async def updateTest():
    try:
        data = request.data.decode('utf8')
        if await check_user(loads(data)['changed']['login']) == 'admin':
            output = {'exit': await update(loads(data))}
            return output
        else:
            raise ValueError('Нет прав!')

    except ValueError as e:
        print("Ошибка: ", e)
        return e
    except Exception as e:
        print('Ошибка: ', e)

@app.post('/deleteTest')
async def deleteTest():
    try:
        data = request.data.decode('utf8')

        if await check_user(loads(data)['login']) == 'admin':
            output = {'exit': await drop(loads(data)['test_id'])}
            return output
        else:
            raise ValueError('Нет прав!')

    except ValueError as e:
        print("Ошибка: ", e)
        return e
    except Exception as e:
        print('Ошибка: ', e)
    
