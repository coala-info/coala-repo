---
name: flask-script
description: Flask-Script provides a structured way to create and manage command-line scripts for Flask applications. Use when user asks to create custom CLI commands, manage database migrations, or run a development server in legacy Flask environments.
homepage: https://github.com/smurfix/flask-script
---


# flask-script

## Overview

Flask-Script is a legacy extension for the Flask web framework that provides a structured way to create and manage command-line scripts. While modern Flask (0.11+) includes a built-in CLI based on Click, Flask-Script is still frequently encountered in older codebases or specific environments where its `Manager` class and decorator-based command registration are preferred. It is primarily used for tasks like database migrations, administrative scripts, and launching the development server with custom parameters.

## Core Usage Patterns

### Initializing the Manager
The entry point for Flask-Script is typically a file named `manage.py`.

```python
from flask_script import Manager
from myapp import app

manager = Manager(app)

if __name__ == "__main__":
    manager.run()
```

### Creating Custom Commands
There are three primary ways to define commands:

1.  **Simple Commands**: Use the `@command` decorator for functions that don't require complex arguments.
    ```python
    @manager.command
    def hello():
        "Prints hello"
        print("hello")
    ```

2.  **Commands with Options**: Use `@option` for fine-grained control over CLI flags.
    ```python
    @manager.option('-n', '--name', dest='name', default='joe')
    def hello(name):
        print("hello", name)
    ```

3.  **Command Classes**: Inherit from the `Command` class for complex logic.

### Built-in Commands
Flask-Script provides several standard commands that can be added to your manager:
- `Shell`: Starts a Python shell within the application context.
- `Server`: Runs the development server (replaces `app.run()`).

```python
from flask_script import Shell, Server

def make_shell_context():
    return dict(app=app, db=db, User=User)

manager.add_command("shell", Shell(make_context=make_shell_context))
manager.add_command("runserver", Server(host="0.0.0.0", port=5000))
```

## Expert Tips and Best Practices

- **Application Context**: Flask-Script automatically pushes the application context before running a command. This allows you to access `current_app`, `g`, and database sessions directly within your functions.
- **Sub-Managers**: For large applications, use `manager.add_command('namespace', sub_manager)` to group related commands (e.g., `python manage.py db upgrade`).
- **Deprecation Awareness**: Always check if the project can be migrated to the native `flask` CLI. Flask-Script is archived and no longer actively developed.
- **Shell Context**: Always populate the `make_context` dictionary for the `Shell` command. This saves significant time by pre-importing models and utility functions.
- **Prompting**: Use `prompt`, `prompt_bool`, and `prompt_choices` from `flask_script` for interactive CLI scripts to ensure consistent user input handling.

## Reference documentation
- [Flask-Script README](./references/github_com_smurfix_flask-script.md)