from typing import Optional
import asyncpg
from asyncpg.connection import Connection

class DB:
    def __init__(self, database_url: str):
        self.conn: Optional[asyncpg.Connection] = None
        self.database_url = database_url

    async def get_conn(self) -> Optional[asyncpg.Connection]:
        if self.conn is None:
            print('Database connection not found')
        return self.conn

    async def connect(self) -> Optional[asyncpg.Connection]:
        if not self.conn:
            self.conn = await asyncpg.connect(self.database_url)
        return self.conn

    async def close(self) -> None:
        if self.conn:
            await self.conn.close()
            self.conn = None