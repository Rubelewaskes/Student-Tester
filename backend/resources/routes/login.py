from flask import request
from json import loads
from resources import app
from resources.queries import check_user_login


@app.post('/login')
async def loginUser():
    try:

        data = request.data.decode('utf8')
        output = await check_user_login(loads(data)['login'], loads(data)['password'])
        return output

    except ValueError as e:
        print("Ошибка: ", e)
    except Exception as e:
        print('Ошибка: ', e)
    