from resources import DB
from resources.services import json_serializable
from resources.settings import database_url


async def getAllGroups():
    try:
        db = DB(database_url=database_url)
        await db.connect()
        data = await db.conn.fetch(
            '''
                select * from tester.studygroup;
            '''
        )

        groups = json_serializable('grp')

        for item in data:
            groups.new_features_tuple()
            groups.add_features('group_id', int(item['group_id']))
            groups.add_features('name', str(item['group_name']))
        
        result = json_serializable('res')
        result.new_features_tuple()
        result.add_features('groups', groups.data)

        return result.data[0]

    except Exception as e:
        print('Exception: ', e)