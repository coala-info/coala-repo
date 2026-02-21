---
name: estmapper
description: The estmapper skill provides procedural knowledge for deploying and maintaining a specialized Django application designed for Automata Theory testing.
homepage: https://github.com/estmapper/1234
---

# estmapper

## Overview
The estmapper skill provides procedural knowledge for deploying and maintaining a specialized Django application designed for Automata Theory testing. It streamlines the transition from repository cloning to a fully functional local environment, ensuring that database schemas are correctly applied and administrative access is established.

## Environment Configuration
To prepare the local environment, follow this sequence:

1. **Virtual Environment**: Initialize a clean Python environment to isolate dependencies.
   ```bash
   python -m venv venv
   source venv/bin/activate  # On Windows use: venv\Scripts\activate
   ```

2. **Dependency Installation**: Install the required packages via the project's requirements file.
   ```bash
   pip install -r requirements.txt
   ```

## Database and Application Management
The application relies on Django's migration system to manage the Automata Theory test data and user records.

1. **Schema Initialization**: Generate and apply database migrations.
   ```bash
   python manage.py makemigrations
   python manage.py migrate
   ```

2. **Administrative Setup**: Create an initial superuser to access the Django admin interface for managing test content.
   ```bash
   python manage.py createsuperuser
   ```

3. **Development Server**: Launch the local server to preview the application.
   ```bash
   python manage.py runserver
   ```

## Project Structure Notes
- **Core Logic**: The primary application logic resides within the `online_tests` and `automata_theory` directories.
- **Templates**: UI components and HTML files are located in the `templates` directory.
- **Containerization**: For Docker-based deployments, utilize the provided `Dockerfile` and `docker-compose.yml` to orchestrate the environment.

## Reference documentation
- [Main Repository and Setup](./references/github_com_estmapper_1234.md)