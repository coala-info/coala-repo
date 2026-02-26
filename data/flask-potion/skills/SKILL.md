---
name: flask-potion
description: Flask-Potion is a resource-oriented framework for building RESTful APIs with Flask that automates CRUD operations and schema generation. Use when user asks to build RESTful APIs, link resources to database models, implement filtering and sorting, or manage API permissions and JSON Hyper-Schemas.
homepage: https://github.com/biosustain/potion
---


# flask-potion

## Overview
Flask-Potion is a resource-oriented framework designed to streamline the creation of robust RESTful APIs. It abstracts the boilerplate of CRUD operations by linking API resources directly to database models while providing built-in support for JSON Hyper-Schema, permissions, and advanced querying. It is ideal for developers who want a self-documenting API that follows strict REST patterns without manually writing every endpoint.

## Core Implementation Pattern
To implement a Potion API, follow this sequence:
1. **Initialize the API**: Bind the `flask_potion.Api` object to your Flask application instance.
2. **Define Model Resources**: Create classes inheriting from `ModelResource`.
3. **Configure Meta**: Use the `Meta` inner class within your resource to define the `model`. This is where you also specify `include_fields`, `exclude_fields`, and `read_only_fields`.
4. **Register Resources**: Use `api.add_resource(YourResource)` to expose the endpoints.

## Advanced Routing and Logic
- **ItemRoute**: Use the `@ItemRoute` decorator for actions targeting specific resource instances (e.g., `/user/1/greeting`).
- **Route**: Use the `@Route` decorator for collection-level actions (e.g., `/user/search`).
- **Type Hinting**: Always provide return type hints using `fields` (e.g., `-> fields.String()`) to ensure the auto-generated schema remains accurate.

## Filtering, Sorting, and Pagination
Potion provides a standardized query language via URL parameters:
- **Filtering**: Use the `where` parameter with a JSON object: `GET /user?where={"name": "Alice"}`.
- **Sorting**: Use the `sort` parameter: `GET /user?sort={"name": 1}` (1 for ascending, -1 for descending).
- **Pagination**: Control output using `per_page` and `page` parameters.
- **Natural Keys**: Define `natural_keys` in the `Meta` class to allow resources to be referenced by unique attributes (like a slug or username) instead of just an integer ID.

## Expert Tips and Best Practices
- **Schema Discovery**: Navigate to the `/schema` endpoint of your API to view the generated JSON Hyper-Schema. This is the source of truth for client-side integrations.
- **Permissions System**: Leverage the optional permissions system to define access control at the resource or route level rather than hardcoding checks inside your logic.
- **Signals**: Use Potion's signal system (e.g., `before_create`, `after_update`) to handle side effects like sending emails or updating search indexes without polluting the resource logic.
- **Relational Queries**: Use `fields.ToOne` and `fields.ToMany` to define relationships. Potion handles the resolution of these links automatically in the JSON response.

## Reference documentation
- [Flask-Potion README](./references/github_com_biosustain_potion.md)