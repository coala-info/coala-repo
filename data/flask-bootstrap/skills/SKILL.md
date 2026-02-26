---
name: flask-bootstrap
description: This tool scaffolds production-ready Flask applications using the cookiecutter-flask boilerplate with integrated Bootstrap 5, database management, and authentication. Use when user asks to create a new Flask project, initialize a database migration, manage frontend assets with webpack, or run tests using pytest.
homepage: https://github.com/cookiecutter-flask/cookiecutter-flask
---


# flask-bootstrap

## Overview
This skill facilitates the rapid development of production-ready Flask applications using the cookiecutter-flask boilerplate. It integrates Bootstrap 5 for responsive styling, webpack for asset bundling and minification, and a robust suite of extensions for database management (SQLAlchemy/Migrate) and user authentication (Login/Bcrypt). It is designed for developers who want to follow the "Twelve-Factor App" methodology and utilize best practices like Blueprints and the Application Factory pattern.

## Project Initialization

### Standard Installation
To create a new project using the standard Python environment (requires Python ≥ 3.8):
1. Install cookiecutter: `pip install cookiecutter`
2. Generate the project: `cookiecutter https://github.com/cookiecutter-flask/cookiecutter-flask.git`
3. Follow the interactive prompts to set your project name, app name, and configuration preferences.

### Docker-based Scaffolding (Preferred)
Using Docker ensures a consistent environment and handles dependencies automatically:
1. Clone the template: `git clone https://github.com/cookiecutter-flask/cookiecutter-flask.git`
2. Run the Docker script: `./cookiecutter-docker.sh`
3. Use the `--build` flag if you need to rebuild the image before running: `./cookiecutter-docker.sh --build`

## Core CLI Operations

### Database Management
The template uses Flask-Migrate (Alembic) for handling schema changes:
- Generate a migration script: `flask db migrate -m "Description of changes"`
- Apply migrations to the database: `flask db upgrade`
- Revert the last migration: `flask db downgrade`

### Asset Management
Frontend assets (CSS/JS) are managed via npm and webpack:
- Install frontend dependencies: `npm install`
- Build assets for production: `npm run build`
- Watch for changes during development: `npm run start` (often integrated into the flask run command or docker-compose)

### Testing
The template includes a pre-configured test suite using pytest and Factory-Boy:
- Run all tests: `pytest`
- Run tests with coverage: `pytest --cov`

## Expert Tips and Best Practices

- **Environment Configuration**: Always use environment variables for configuration (e.g., `FLASK_DEBUG`, `DATABASE_URL`). The template is built to read these automatically to comply with Twelve-Factor App standards.
- **Blueprints**: Organize your application logic into Blueprints. The template provides a default structure where each blueprint contains its own views, models, and forms.
- **Authentication**: Leverage the built-in `User` model and `Flask-Login` integration. Password hashing is handled automatically via `Flask-Bcrypt`.
- **CLI Extensions**: Use the `flask` command-line interface to add custom management commands. The template's `Click` CLI is configured in `tasks.py` or the app factory.
- **Deployment**: The included `Procfile` is ready for PaaS deployments like Heroku. For containerized environments, use the provided `Dockerfile`.

## Reference documentation
- [cookiecutter-flask Main Repository](./references/github_com_cookiecutter-flask_cookiecutter-flask.md)