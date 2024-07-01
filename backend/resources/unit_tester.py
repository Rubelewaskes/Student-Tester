#self.assertRaises(ValueError, res)
from resources.queries import check_user_login
from unittest import IsolatedAsyncioTestCase
import asyncio

class TgroupsTestest(IsolatedAsyncioTestCase):

    async def test_functionality(self):
        result = await check_user_login("test", "1234")
        self.assertEqual(1, result)

if __name__ == "__main__":
    asyncio.run(TgroupsTestest())