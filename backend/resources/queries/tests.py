from resources.services import json_serializable
from resources import DB
from resources.settings import database_url
from resources.settings import database_url_student
from resources.settings import database_url_teacher
from resources.settings import database_url_admin
from datetime import datetime

async def getStudentTests(group_id):
    try:
        db = DB(database_url=database_url)
        await db.connect()
        data = await db.conn.fetch(
                f'''
                    select 
                        tst.test_id, 
                        tst.test_name,
                        tst.discipline,
                        tst.end_time, 
                        tst.minimum_score, 
                        teach.second_name || ' ' || 
                        left(teach.first_name, 1) || '. ' || 
                        left(teach.third_name, 1) ||'.' as fio_teacher,
                        case
                            when tst.end_time > now() then 1
                            else 0
                        end as is_present
                        from tester.test tst 
                        join tester.teacher teach 
                        on tst.teacher_id = teach.teacher_id
                        join tester.grouptest gt 
                        on tst.test_id = gt.test_id
                        where tst.start_time < now() and gt.group_id = {group_id}
                        order by tst.end_time desc;
                '''
                )

        result = json_serializable('res')
        present = json_serializable('pres')
        past = json_serializable('past')

        for item in data:
            
            if (int(item['is_present']) == 1):
                present.new_features_tuple()
                present.add_features('test_id', int(item['test_id']))
                present.add_features('test_name', str(item['test_name']))
                present.add_features('discipline', str(item['discipline']))
                present.add_features('end_time', datetime.strptime(str(item['end_time']), "%Y-%m-%d %H:%M:%S").strftime("%d.%m.%Y %H:%M"))
                present.add_features('minimum_score', int(item['minimum_score']))
                present.add_features('fio_teacher', str(item['fio_teacher']))
                
            else:
                past.new_features_tuple()
                past.add_features('test_id', int(item['test_id']))
                past.add_features('test_name', str(item['test_name']))
                past.add_features('discipline', str(item['discipline']))
                past.add_features('end_time', datetime.strptime(str(item['end_time']), "%Y-%m-%d %H:%M:%S").strftime("%d.%m.%Y %H:%M"))
                past.add_features('minimum_score', int(item['minimum_score']))
                past.add_features('fio_teacher', str(item['fio_teacher']))
                
        result.new_features_tuple()
        result.add_features('present', present.data)
        result.add_features('past', past.data)
        await db.close()

        return result.data[0]
        
    except Exception as e:
        print('Exception: ', e)

async def getTeacherTests(teacher_id):
    try:
        db = DB(database_url=database_url)
        await db.connect()
        data = await db.conn.fetch(
                f'''
                    select 
                        tst.test_id, 
                        tst.test_name,
                        tst.discipline,
                        tst.end_time, 
                        tst.minimum_score, 
                        teach.second_name || ' ' || 
                        left(teach.first_name, 1) || '. ' || 
                        left(teach.third_name, 1) ||'.' as fio_teacher,
                        case
                            when tst.end_time > now() then 1
                            else 0
                        end as is_present
                        from tester.test tst 
                        join tester.teacher teach 
                        on tst.teacher_id = teach.teacher_id
                        where tst.teacher_id = {teacher_id}
                        order by tst.end_time desc;
                '''
                )

        result = json_serializable('res')
        present = json_serializable('pres')
        past = json_serializable('past')

        for item in data:
            
            if (int(item['is_present']) == 1):
                present.new_features_tuple()
                present.add_features('test_id', int(item['test_id']))
                present.add_features('test_name', str(item['test_name']))
                present.add_features('discipline', str(item['discipline']))
                present.add_features('end_time', datetime.strptime(str(item['end_time']), "%Y-%m-%d %H:%M:%S").strftime("%d.%m.%Y %H:%M"))
                present.add_features('minimum_score', int(item['minimum_score']))
                present.add_features('fio_teacher', str(item['fio_teacher']))
                
            else:
                past.new_features_tuple()
                past.add_features('test_id', int(item['test_id']))
                past.add_features('test_name', str(item['test_name']))
                past.add_features('discipline', str(item['discipline']))
                past.add_features('end_time', datetime.strptime(str(item['end_time']), "%Y-%m-%d %H:%M:%S").strftime("%d.%m.%Y %H:%M"))
                past.add_features('minimum_score', int(item['minimum_score']))
                past.add_features('fio_teacher', str(item['fio_teacher']))
                
        result.new_features_tuple()
        result.add_features('present', present.data)
        result.add_features('past', past.data)
        await db.close()

        return result.data[0]
        
    except Exception as e:
        print('Exception: ', e)


async def getAllTests():
    try:
        db = DB(database_url=database_url)
        await db.connect()
        data = await db.conn.fetch(
                f'''
                    select 
                        tst.test_id, 
                        tst.test_name,
                        tst.discipline,
                        tst.end_time, 
                        tst.minimum_score, 
                        teach.second_name || ' ' || 
                        left(teach.first_name, 1) || '. ' || 
                        left(teach.third_name, 1) ||'.' as fio_teacher,
                        case
                            when tst.end_time > now() then 1
                            else 0
                        end as is_present
                        from tester.test tst 
                        join tester.teacher teach 
                        on tst.teacher_id = teach.teacher_id
                        order by tst.end_time desc;
                '''
                )

        result = json_serializable('res')
        present = json_serializable('pres')
        past = json_serializable('past')

        for item in data:
            
            if (int(item['is_present']) == 1):
                present.new_features_tuple()
                present.add_features('test_id', int(item['test_id']))
                present.add_features('test_name', str(item['test_name']))
                present.add_features('discipline', str(item['discipline']))
                present.add_features('end_time', datetime.strptime(str(item['end_time']), "%Y-%m-%d %H:%M:%S").strftime("%d.%m.%Y %H:%M"))
                present.add_features('minimum_score', int(item['minimum_score']))
                present.add_features('fio_teacher', str(item['fio_teacher']))
                
            else:
                past.new_features_tuple()
                past.add_features('test_id', int(item['test_id']))
                past.add_features('test_name', str(item['test_name']))
                past.add_features('discipline', str(item['discipline']))
                past.add_features('end_time', datetime.strptime(str(item['end_time']), "%Y-%m-%d %H:%M:%S").strftime("%d.%m.%Y %H:%M"))
                past.add_features('minimum_score', int(item['minimum_score']))
                past.add_features('fio_teacher', str(item['fio_teacher']))
                
        result.new_features_tuple()
        result.add_features('present', present.data)
        result.add_features('past', past.data)
        await db.close()

        return result.data[0]
        
    except Exception as e:
        print('Exception: ', e)
    return result    


async def getQuestions(test_id):
    try:
        db = DB(database_url=database_url)
        await db.connect()
        data = await db.conn.fetch(
                f'''
                    select question_id, question_content from tester.question where test_id = { test_id };
                '''
                )

        result = json_serializable('res')
        question = json_serializable('qst')
        
        for item in data:
            data_answers = await db.conn.fetch(
                f'''
                    select answer_content from tester.answervariant where question_id = {item['question_id']};
                '''
            )
            
            answers = []

            for answer in data_answers:
                answers.append(answer['answer_content'])

            question.new_features_tuple()
            question.add_features('question_id', int(item['question_id']))
            question.add_features('question_content', str(item['question_content']))
            question.add_features('answers', answers)
        
        result.new_features_tuple()
        result.add_features('questions', question.data)
        await db.close()
        
        return result.data[0]

    except Exception as e:
        print('Exception: ', e)


async def getNameTest(test_id):
    try:
        db = DB(database_url=database_url)
        await db.connect()
        data = await db.conn.fetch(
                f'''
                    select test_name from tester.test where test_id = { test_id };
                '''
                )
        await db.close()
        
        return str(data[0]['test_name'])

    except Exception as e:
        print('Exception: ', e)


async def postAnswer(data):
    try:
        db = DB(database_url=database_url_student)
        await db.connect()

        current = await db.conn.fetch(
            f'''select 
                case
                    when tst.end_time > now() then 1
                    else 0
                end as current
                from tester.question que
                join tester.test tst 
                on que.test_id = tst.test_id
                where que.question_id = {data[0]['question_id']};
            '''
        )
        if current[0]['current'] == 0:
            return "Ошибка. Время истекло. Тест закрыт"

        for item in data:
            findAnswer = await db.conn.fetch(
                f'''
                select count(*) from tester.answer where student_id = {item['user_id']} and question_id = {item['question_id']};
                '''
            )
            if findAnswer[0]['count'] != 0:
                return "Ошибка. Вы уже сдавали этот тест"

        async with db.conn.transaction():
            for item in data:
                await db.conn.execute(
                    f'''
                    insert into tester.answer (student_id, question_id, answer_content)
                    values ({item['user_id']}, {item['question_id']}, '{item['answer']}');
                    '''
                )

        await db.close()
        return "success"

        
    except Exception as e:
        print('Exception: ', e)

async def createTest(data):
    try:
        db = DB(database_url=database_url_teacher)
        await db.connect()
        async with db.conn.transaction():

            test_id = await db.conn.fetchval(
                    f'''
                    insert into tester.test (test_name, discipline, start_time, end_time, minimum_score, teacher_id)
                    values('{data['name']}','{data['discipline']}', '{ datetime.fromisoformat(data['start_date']) }', 
                    '{ datetime.fromisoformat(data['end_date']) }', {data['minimum_score']}, {int(data['teacher_id'])})
                    returning test_id;
                    '''
                )

            for item in data['questions']:
                question_id = await db.conn.fetchval(
                    f'''
                    insert into tester.question (question_content, right_answer, score, test_id)
                    values ('{item['question']}', '{item['rightAnswer']}', {item['score']}, {test_id})
                    returning question_id;
                    '''
                )
                for que in item['answers']:
                    await db.conn.execute(
                        f'''
                        insert into tester.answervariant (answer_content, question_id)
                        values('{que['text']}', {question_id});
                        '''
                    )

            for item in data['groups']:
                await db.conn.execute(
                    f'''
                    insert into tester.grouptest (group_id, test_id)
                    values ({item['group_id']}, {test_id});
                    '''
                )
        await db.close()
        return "success"

    except Exception as e:
        print('Exception: ', e)
        return "error"

async def getFullTestInfo(test_id):
    try:
        db = DB(database_url=database_url)
        await db.connect()
        test_data = await db.conn.fetch(
            f'''
            select * from tester.test where test_id = {test_id};
            '''
        )

        test = json_serializable('tst')
        test.new_features_tuple()
        test.add_features('name', str(test_data[0]['test_name']))
        test.add_features('discipline', str(test_data[0]['discipline']))
        test.add_features('end_date', datetime.strptime(str(test_data[0]['end_time']), "%Y-%m-%d %H:%M:%S").strftime("%Y-%m-%dT%H:%M"))
        test.add_features('start_date', datetime.strptime(str(test_data[0]['start_time']), "%Y-%m-%d %H:%M:%S").strftime("%Y-%m-%dT%H:%M"))
        test.add_features('minimum_score', int(test_data[0]['minimum_score']))

        questions_data = await db.conn.fetch(
            f'''
            select * from tester.question where test_id = {test_id};
            '''
        )

        question = json_serializable('que')
        
        for item in questions_data:
            answer = json_serializable('que')
            question.new_features_tuple()
            question.add_features('question_id', int(item['question_id']))
            question.add_features('text', str(item['question_content']))
            question.add_features('rightAnswer', str(item['right_answer']))
            question.add_features('score', int(item['score']))
            answervariant_data = await db.conn.fetch(
                f'''
                select * from tester.answervariant where question_id = {item['question_id']};
                '''
            )
            for answerItem in answervariant_data:
                answer.new_features_tuple()
                answer.add_features('answervariant_id', str(answerItem['answervariant_id']))
                answer.add_features('text', str(answerItem['answer_content']))
            
            question.add_features('answers', answer.data)

        groups_data = await db.conn.fetch(
            f'''
            select gt.group_test_id, gt.group_id, g.group_name
            from tester.grouptest gt 
            join tester.studygroup g on g.group_id = gt.group_id
            where gt.test_id = {test_id};
            '''
        )

        groups = json_serializable('gr')
        for item in groups_data:
            groups.new_features_tuple()
            groups.add_features('group_test_id', int(item['group_test_id']))
            groups.add_features('group_id', int(item['group_id']))
            groups.add_features('name', str(item['group_name']))

        result = json_serializable('result')
        result.new_features_tuple()
        result.add_features('testData', test.data[0])
        result.add_features('questions', question.data)
        result.add_features('selectedGroups', groups.data)

        await db.close()
        
        return result.data[0]

    except Exception as e:
        print('Exception: ', e)
        return "error"

async def update(data):
    try:
        db = DB(database_url=database_url_admin)
        await db.connect()
        async with db.conn.transaction():
            await db.conn.execute(
                    f'''
                        update tester.test 
                        set test_name = '{data['changed']['name']}', 
                        discipline = '{data['changed']['discipline']}', 
                        start_time = '{ datetime.fromisoformat(data['changed']['start_date']) }', 
                        end_time = '{ datetime.fromisoformat(data['changed']['end_date']) }', 
                        minimum_score = {data['changed']['minimum_score']}
                        where test_id = {data['changed']['test_id']};
                    '''
                )

            for item in data['changed']['questions']:
                if item['question_id'] != '-1':
                    await db.conn.fetchval(
                    f'''
                        update tester.question
                        set question_content = '{item['question']}', 
                        right_answer = '{item['rightAnswer']}', 
                        score = {item['score']}
                        where question_id = {item['question_id']}
                    '''
                    )

                    for que in item['answers']:
                        if que['answervariant_id'] != '-1':
                            await db.conn.execute(
                                f'''
                                update tester.answervariant 
                                set answer_content ='{que['text']}'
                                where answervariant_id = {que['answervariant_id']}
                                '''
                            )
                        else:
                            await db.conn.execute(
                                f'''
                                    insert into tester.answervariant (answer_content, question_id)
                                    values('{que['text']}', {item['question_id']});
                                '''
                            )
                else:
                    question_id = await db.conn.fetchval(
                    f'''
                        insert into tester.question (question_content, right_answer, score, test_id)
                        values ('{item['question']}', '{item['rightAnswer']}', {item['score']}, {data['changed']['test_id']})
                        returning question_id;
                    '''
                    )
                    for que in item['answers']:
                        await db.conn.execute(
                            f'''
                                insert into tester.answervariant (answer_content, question_id)
                                values('{que['text']}', {question_id});
                            '''
                        )

            for item in data['changed']['groups']:
                if item['group_test_id'] != '-1':
                    await db.conn.execute(
                        f'''
                        update tester.grouptest
                        set group_id = {item['group_id']}
                        where group_test_id = {item['group_test_id']}
                        '''
                    )
                else:
                    for item in data['changed']['groups']:
                        await db.conn.execute(
                            f'''
                                insert into tester.grouptest (group_id, test_id)
                                values ({item['group_id']}, {data['changed']['test_id']});
                            '''
                        )

            for item in data['deleted']['groups']:
                if item != '-1':
                    await db.conn.execute(
                            f'''
                                delete from tester.grouptest 
                                where group_test_id = {item};
                            '''
                        )

            for item in data['deleted']['answers']:
                if item != '-1':
                    await db.conn.execute(
                            f'''
                                delete from tester.answervariant 
                                where answervariant_id = {item};
                            '''
                        )

            for item in data['deleted']['questions']:
                if item != '-1':
                    await db.conn.execute(
                            f'''
                                delete from tester.questions
                                where question_id = {item};
                            '''
                        )

        await db.close()
        return "success"

    except Exception as e:
        print('Exception: ', e)
        return "error"


async def drop(test_id):
    try:
        db = DB(database_url=database_url_admin)
        await db.connect()
        await db.conn.execute(
            f'''
            delete from tester.test where test_id = {test_id};
            '''
        )

        await db.close()
        return 'success'

    except Exception as e:
        print('Exception: ', e)
        return "error"