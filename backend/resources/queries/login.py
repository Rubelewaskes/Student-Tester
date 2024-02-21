from resources.services import hash_pass, json_serializable
from resources import DB
from resources.settings import database_url
from resources.settings import database_url_login


async def check_user_login(login, password):
    try:
        dbU = DB(database_url=database_url_login)
        await dbU.connect()
        
        data = await dbU.conn.fetch(
            f'''
                select 
                    u.user_login, 
                    u.user_password, 
                    r.role_name,
                    r.role_sys_name
                from 
                    tester_users.users u
                join tester_users.roles r
                    on r.role_id = u.role_id
                where u.user_login = '{login}';
            '''
            )
            
        if hash_pass.hash_check('pbkdf2:sha256:260000$'+str(data[0]['user_password']), password):
                
            result = json_serializable('res')
            result.new_features_tuple()
            result.add_features('login', str(data[0]['user_login']))
            result.add_features('role', str(data[0]['role_name']))
            result.add_features('role_sys', str(data[0]['role_sys_name']))


            db = DB(database_url=database_url)
            await db.connect()
            if (data[0]['role_sys_name'] != 'admin'):

                if(data[0]['role_sys_name'] == 'teacher'):
                    user_data = await db.conn.fetch(
                    f'''
                        select
                            teacher_id,
                            second_name,
                            first_name,
                            third_name
                        from tester.teacher
                        where login = '{str(data[0]['user_login'])}';
                    '''
                    )
                else:
                    user_data = await db.conn.fetch(
                    f'''
                        select
                            student_id,
                            second_name,
                            first_name,
                            third_name,
                            group_id
                        from tester.student
                        where login = '{str(data[0]['user_login'])}';
                    '''
                    )
                    result.add_features('group_id', str(user_data[0]['group_id']))

                result.add_features('first_name', str(user_data[0]['first_name']))
                result.add_features('second_name', str(user_data[0]['second_name']))
                result.add_features('third_name', str(user_data[0]['third_name']))
                result.add_features('token', str(user_data[0][str(data[0]['role_sys_name'])+'_id']))

            else:
                result.add_features('first_name', str(data[0]['user_login']))
                result.add_features('second_name', '')
                result.add_features('third_name', '')
                result.add_features('token', '-1')   
            
            await dbU.close()
            await db.close()
            return result.data[0]       
        raise ValueError ('Введены некорректные данные.')
    
    except Exception as e:
        print('Exception: ', e)
    except ValueError as e:
        print("Exception:", e)

async def check_user(login):
    try:
        dbU = DB(database_url=database_url_login)
        await dbU.connect()
        
        data = await dbU.conn.fetch(
            f'''
                select
                    r.role_sys_name
                from 
                    tester_users.users u
                join tester_users.roles r
                    on r.role_id = u.role_id
                where u.user_login = '{login}';
            '''
        )
        return data[0]['role_sys_name']

    except Exception as e:
        print('Exception: ', e)