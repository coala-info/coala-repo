---
name: peewee
description: Peewee is a minimalist Object-Relational Mapper (ORM) for Python that prioritizes simplicity and expressiveness.
homepage: https://github.com/coleifer/peewee
---

# peewee

## Overview

Peewee is a minimalist Object-Relational Mapper (ORM) for Python that prioritizes simplicity and expressiveness. It allows developers to interact with databases using Python classes (Models) and method chaining for queries, making it highly readable and easy to maintain. This skill provides guidance on defining models, executing expressive queries, and managing database connections efficiently.

## Core Usage Patterns

### 1. Database and Model Definition
Always use a `BaseModel` to avoid repeating the database configuration in every model.

```python
from peewee import *

db = SqliteDatabase('app.db')

class BaseModel(Model):
    class Meta:
        database = db

class User(BaseModel):
    username = CharField(unique=True)
    email = CharField()

class Tweet(BaseModel):
    user = ForeignKeyField(User, backref='tweets')
    message = TextField()
    created_date = DateTimeField(constraints=[SQL('DEFAULT CURRENT_TIMESTAMP')])
```

### 2. Connection Management
Ensure tables are created before use and connections are handled properly.

```python
db.connect()
db.create_tables([User, Tweet])
# ... logic ...
db.close()
```

### 3. Expressive Querying
Peewee uses Pythonic operators for SQL filtering.

*   **Filtering**: Use `==`, `!=`, `<`, `>`, `<<` (IN), and `@` (LIKE).
*   **Combining**: Use `&` (AND) and `|` (OR).

```python
# Select users with specific names
users = User.select().where(User.username << ['alice', 'bob'])

# Join and filter
tweets = (Tweet
          .select()
          .join(User)
          .where(User.username == 'alice'))
```

### 4. Atomic Updates
To prevent race conditions, use the model's update method with expressions rather than fetching and saving.

```python
# Atomic increment
Counter.update(count=Counter.count + 1).where(Counter.url == 'example.com').execute()
```

### 5. Aggregation and Functions
Use the `fn` object to access SQL functions like `Count`, `Max`, or `Sum`.

```python
# Count tweets per user
tweet_ct = fn.Count(Tweet.id)
query = (User
         .select(User, tweet_ct.alias('count'))
         .join(Tweet, JOIN.LEFT_OUTER)
         .group_by(User))
```

## Expert Tips

*   **Pwiz (Introspection)**: Use the `pwiz` CLI tool to generate Peewee model code from an existing database:
    `python -m pwiz -e postgresql my_database > models.py`
*   **Backrefs**: Always define a `backref` in `ForeignKeyField` to allow easy reverse-lookups (e.g., `user.tweets` to get all tweets for a user instance).
*   **Pagination**: Use `.paginate(page_number, items_per_page)` for easy result splitting.
*   **Performance**: Use `.dicts()` or `.tuples()` on a query to get raw data instead of model instances when performance is critical and you don't need model methods.

## Reference documentation
- [Peewee GitHub Repository](./references/github_com_coleifer_peewee.md)
- [Peewee Wiki](./references/github_com_coleifer_peewee_wiki.md)