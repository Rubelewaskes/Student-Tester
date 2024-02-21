from resources import app
from resources.routes import login
from resources.routes import tests
from resources.routes import groups
from resources.routes import results
from flask import request


@app.route('/')
def main():
    return '''
        <div class="flex">
            <h2 align="middle" class = "text">tester 1.0</h2>
        </div>
        <style>
            body{
                background-size: 100% 100%;
                background-repeat: no-repeat;
                background-image: url(https://skazka-arkhyz.ru/wp-content/uploads/9/b/f/9bfcbce22d279af407c11846bdb6c7bc.jpeg);
            }
            .text{
                font-size: 30pt;
                color: black;
            }
            .flex {
                align-content: center;
                text-align: center;
                text-shadow: 1px 1px 2px blue, 0 0 1em blue, 0 0 0.2em blue;
                width: 100%;
                height: 800px;
            }
        </style>
    '''