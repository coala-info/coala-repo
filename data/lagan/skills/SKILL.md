---
name: lagan
description: Lagan is a model-first Content Management System that automatically generates database tables and administration panels from PHP class definitions. Use when user asks to architect content objects, handle data persistence via the RedBean ORM, or develop front-end routes and templates.
homepage: https://github.com/lutsen/lagan
---


# lagan

## Overview

Lagan is a flexible, code-centric Content Management System designed for developers who want control over their data structures without building a backend from scratch. It uses a "model-first" approach where defining a PHP class automatically generates the corresponding database tables and a web-based administration panel. Use this skill to architect content objects, handle data persistence via the RedBean ORM, and develop front-end routes and templates.

## Installation and Setup

Install Lagan using Composer to scaffold the project structure, including the Slim framework and RedBean ORM.

- **Initialize project**: Run `php composer.phar create-project lagan/lagan [project-name]`.
- **Configure environment**: Edit `config.php` immediately after installation to set database credentials, server paths, and admin authentication.
- **Security**: Change the default admin password in `config.php` and ensure the site runs over HTTPS, as Lagan uses HTTP Basic Authentication for the backend.

## Content Model Development

Models are the core of Lagan. They must be placed in the `models/lagan/` directory and extend the base Lagan class.

- **Define a model**: Create a class in the `Lagan\Model` namespace.
- **Required properties**: Every model must include a `title` property of type `\Lagan\Property\Str`.
- **Property structure**: Define properties in an array within the constructor. Each property requires:
    - `name`: Alphanumeric identifier (used as the RedBean property name).
    - `description`: The label shown in the admin interface.
    - `type`: The PHP controller class for the data type (e.g., `\Lagan\Property\Str`).
    - `input`: The template used for the admin form (e.g., `text`).

### Example Model Pattern
```php
namespace Lagan\Model;
class Project extends \Lagan\Lagan {
    function __construct() {
        $this->type = 'project';
        $this->description = 'Project portfolio items.';
        $this->properties = [
            [
                'name' => 'title',
                'description' => 'Project Name',
                'type' => '\Lagan\Property\Str',
                'input' => 'text',
                'required' => true
            ]
        ];
    }
}
```

## Data Manipulation (CRUD)

Lagan models inherit CRUD methods that interact with the database via RedBean "beans."

- **Create**: Use `$model->create($data)` where `$data` is an associative array (typically from a POST request).
- **Read**: Use `$model->read($id)` to retrieve a specific bean, or `$model->read()` to retrieve all beans of that type.
- **Update**: Use `$model->update($data, $id)` to modify existing records.
- **Delete**: Use `$model->delete($id)` to remove a record.

## Routing and Templates

- **Public Routes**: Define Slim routes in `routes/public.php`. Use these routes to fetch data via models and pass them to Twig.
- **Twig Templates**: Place front-end templates in `templates/public/`.
- **Admin Customization**: Add custom property templates to `public/property-templates/` to extend the admin interface's input capabilities.

## Best Practices

- **Automated Schema**: Let Lagan handle database migrations; it automatically creates or updates tables based on your `$this->properties` definition.
- **Validation**: Use the `validate` key in property arrays (e.g., `'validate' => 'minlength(3)'`) to enforce data integrity.
- **Search**: Set `'searchable' => true` on specific properties to enable them in the admin search controller.
- **Unique Values**: Use `'unique' => true` for properties like slugs or SKUs to prevent duplicate entries.

## Reference documentation
- [Lagan Main Documentation](./references/github_com_lutsen_lagan.md)
- [Model Structure and Methods](./references/github_com_lutsen_lagan_tree_master_models_lagan.md)