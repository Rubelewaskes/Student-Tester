# Система тестирования студентов (курсовой проект)

Предметная область:
Студент может выбирать предмет, по которому можно пройти тестирование. После прохождения тестов он может посмотреть количество правильных ответов и свою оценку, а также статистику прохождения данного теста среди своих одногруппников. Пользователи с ролью «Студент» формируются в группы в зависимости от их учебных групп, направлений подготовки и курса. В зависимости от этих же факторов студенту доступны задания по разным предметам.
Преподаватель должен иметь возможность создавать тесты и просматривать результаты по группам. Администратор должен иметь возможность редактировать тесты и также просматривать результаты.

## Backend

### Настройка (терминал 1)

> **Необходим Python версии 3.9 и выше**

Настройка директории и установка зависимостей (windows)

```ps
$ cd backend

$ python -m venv env

$ env/scripts/activate

$ powershell

$ New-Item -ItemType file -Path './resources/settings.py'

$ exit

$ pip install -r requirements.txt
```

#### Содержимое settings.py

```python
database_url = 'postgres://username:password@host:port/database'
host = ''
```

### Запуск

```console
$ cd backend

$ python app.py
```

## Frontend

### Настройка (терминал 2)

> **Необходим предустановленный [Node JS]**

```ps
$ cd frontend

$ npm install vue

$ npm install --force
```

### Запуск

```console

$ npm run serve
```

## DataBase (PostgreSQL)

> **Для полноценной работы программы рекомендуется запустить докер на основе бекапа сервера в папке database. В backend/settings.py содержатся строки подключения в случае изменения параметров сервера необходимо их исправить.**
