---
name: arden
description: Arden is an extension for Laravel's Eloquent ORM that provides self-contained model validation and data integrity features. Use when user asks to implement automatic model validation, purge redundant attributes, or hash sensitive fields within Laravel applications.
homepage: https://github.com/laravel-ardent/ardent
metadata:
  docker_image: "biocontainers/arden:v1.0-4-deb_cv1"
---

# arden

## Overview
Ardent is an extension for Laravel's Eloquent ORM that simplifies data integrity by making models "self-aware." Instead of manually triggering validation in controllers, Ardent models automatically validate themselves upon saving. This skill helps you implement cleaner, more maintainable Laravel applications by shifting validation logic and data transformation directly into the model layer.

## Usage and Best Practices

### Installation
Install the package via Composer:
```bash
composer require laravelbook/ardent
```

### Model Definition
To create an Ardent model, extend the `Ardent` base class instead of the standard Eloquent `Model`. Define your validation rules as a static array within the class.

```php
use LaravelArdent\Ardent\Ardent;

class User extends Ardent {
    public static $rules = array(
        'name'     => 'required|between:3,80|alpha_dash',
        'email'    => 'required|between:5,64|email|unique:users',
        'password' => 'required|min:6|confirmed',
    );
}
```

### Core Workflow Patterns
- **Automatic Validation**: Call `$model->save()` as usual. Ardent returns `false` if validation fails, preventing the database write.
- **Manual Validation**: Use `$model->validate()` to check validity without attempting to persist data.
- **Error Retrieval**: If validation fails, access the `Illuminate\Support\MessageBag` via `$model->errors()`.
- **Attribute Purging**: Ardent can automatically remove redundant form data (like `password_confirmation`) before saving if `$autoPurgeRedundantAttributes` is set to `true`.
- **Secure Attributes**: Use the `$hashableAttributes` array to automatically hash sensitive fields like passwords before they hit the database.

### Expert Tips
- **Unique Rules**: Ardent handles the `unique` validation rule intelligently during updates by automatically appending the model's ID to the rule, preventing "email already taken" errors when saving an existing record.
- **Model Hooks**: Leverage Ardent's internal hooks (`beforeSave`, `afterSave`, `beforeCreate`, etc.) to encapsulate business logic that must occur around the persistence lifecycle.
- **Standalone Usage**: For non-Laravel projects, use `Ardent::configureAsExternal()` to initialize the database connection and use Ardent as a standalone ORM.

## Reference documentation
- [Ardent README](./references/github_com_laravel-ardent_ardent.md)