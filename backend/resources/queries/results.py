from resources import DB
from resources.services import json_serializable
from resources.settings import database_url

async def findAnswers(test_id, ident):
    try:
        db = DB(database_url=database_url)
        await db.connect()
        data = await db.conn.fetch(
            f'''
                select count(*) from tester.answer an 
                join tester.question q 
                on an.question_id = q.question_id 
                where an.student_id = {ident} and q.test_id = {test_id};
            '''
        )

        await db.close()
        if int(data[0]['count']) <= 0:
            return {'massive': 'false'}
        else:
            return {'massive': 'true'}
            
    except Exception as e:
        print('Ошибка: ', e)
        return {'massive': []}


async def getColumns(test_id):
    try:
        db = DB(database_url=database_url)
        await db.connect()
        data = await db.conn.fetch(
            f'''
                select count(*) from tester.question where test_id = {test_id};
            '''
        )

        result = json_serializable('res')
        result.new_features_tuple()
        result.add_features('key', 1)
        result.add_features('field', 'number')
        result.add_features('header', 'Номер')

        result.new_features_tuple()
        result.add_features('key', 2)
        result.add_features('field', 'FIO')
        result.add_features('header', 'ФИО')

        result.new_features_tuple()
        result.add_features('key', 3)
        result.add_features('field', 'group')
        result.add_features('header', 'Группа')

        
        
        for i in range(1, int(data[0]['count']) + 1):
            result.new_features_tuple()
            result.add_features('key', 3+i)
            result.add_features('field', f'que{i}')
            result.add_features('header', f'Вопрос {i}')
        
        result.new_features_tuple()
        result.add_features('key', int(data[0]['count']) + 4)
        result.add_features('field', 'result')
        result.add_features('header', 'Итог')

        await db.close()
        return {'massive': result.data}

    except Exception as e:
        print('Ошибка: ', e)
        return {'massive': []}


async def getTableResults(test_id):
    try:
        db = DB(database_url=database_url)
        await db.connect()
        questions = await db.conn.fetch(
            f'''
                select * from tester.question where test_id = {test_id};
            '''
        )
        
        students = await db.conn.fetch(
            f'''
                select s.student_id, sg.group_name,  concat(s.second_name, ' ', 
                substring(s.first_name FROM 1 FOR 1), '.',
                substring(s.third_name FROM 1 FOR 1), '.') as fio from tester.answer an
                join tester.student s on s.student_id = an.student_id
                join tester.studygroup sg on sg.group_id = s.group_id
                where an.question_id = {questions[0]['question_id']};
            '''
        )

        if (students):
            result = json_serializable('res')
            
            for i in range (0, len(students)):
                result.new_features_tuple()
                result.add_features('number', i+1)
                result.add_features('FIO', str(students[i]['fio']))
                result.add_features('group', str(students[i]['group_name']))
                cnt_que = 0
                result_score = 0
                for que in questions:
                    answer = await db.conn.fetch(
                    f'''
                        select
                            case
                                when an.answer_content = q.right_answer THEN q.score
                                else 0
                            end as earned_score
                        from tester.answer an
                        join tester.question q ON an.question_id = q.question_id
                        where an.student_id = {students[i]['student_id']} and q.question_id = {que['question_id']};
                    '''
                    )
                    result.add_features(f'que{cnt_que+1}', int(answer[0]['earned_score']))
                    result_score += int(answer[0]['earned_score'])
                    cnt_que+=1
                result.add_features('result', result_score)
            await db.close()
            print(result.data)
            return {'massive': result.data}
        
        else:
            return {'massive': []}

    except Exception as e:
        print('Ошибка: ', e)
        return {'massive': []}

async def getTableResultsStud(test_id, ident):
    try:
        db = DB(database_url=database_url)
        await db.connect()
        questions = await db.conn.fetch(
            f'''
                select * from tester.question where test_id = {test_id};
            '''
        )

        group_id = await db.conn.fetch(
            f'''
                select group_id from tester.student where student_id = {ident};
            '''
        )
        group_id = int(group_id[0]['group_id'])

        students = await db.conn.fetch(
            f'''
                select s.student_id, sg.group_name,  concat(s.second_name, ' ', 
                substring(s.first_name FROM 1 FOR 1), '.',
                substring(s.third_name FROM 1 FOR 1), '.') as fio from tester.answer an
                join tester.student s on s.student_id = an.student_id
                join tester.studygroup sg on sg.group_id = s.group_id
                where an.question_id = {questions[0]['question_id']}
                and s.group_id = {group_id};
            '''
        )

        if (students):
            result = json_serializable('res')

            for i in range (0, len(students)):
                result.new_features_tuple()
                result.add_features('number', i+1)
                result.add_features('FIO', str(students[i]['fio']))
                result.add_features('group', str(students[i]['group_name']))
                cnt_que = 0
                result_score = 0
                for que in questions:
                    answer = await db.conn.fetch(
                    f'''
                        select
                            case
                                when an.answer_content = q.right_answer THEN q.score
                                else 0
                            end as earned_score
                        from tester.answer an
                        join tester.question q ON an.question_id = q.question_id
                        where an.student_id = {students[i]['student_id']} and q.question_id = {que['question_id']};
                    '''
                    )
                    result.add_features(f'que{cnt_que+1}', int(answer[0]['earned_score']))
                    result_score += int(answer[0]['earned_score'])
                    cnt_que+=1
                result.add_features('result', result_score)
            await db.close()
            return {'massive': result.data}
            
        else:
            return {'massive': []}
    
    except Exception as e:
        print('Ошибка: ', e)
        return {'massive': []}
