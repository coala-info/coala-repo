---
name: perm
description: The perm tool manages roles and permissions in Laravel applications using the Spatie Laravel-Permission package. Use when user asks to assign roles to users, create new permissions, check user authorization, or manage access control lists.
homepage: https://github.com/spatie/laravel-permission
metadata:
  docker_image: "biocontainers/perm:v0.4.0-4-deb_cv1"
---

# perm

## Overview
The `perm` skill facilitates the management of authorization layers in Laravel applications. It leverages the Spatie Laravel-Permission package to associate users with specific roles and individual permissions, which are then automatically registered with Laravel's native Gate system. Use this skill to architect robust Access Control Lists (ACL), handle multi-tenant role assignments, and streamline permission-based UI rendering.

## Core Usage Patterns

### Model Configuration
To enable permission management on a model (typically the User model), ensure the `HasRoles` trait is imported and used:

```php
use Spatie\Permission\Traits\HasRoles;

class User extends Authenticatable
{
    use HasRoles;
}
```

### Assigning Permissions and Roles
Permissions can be assigned directly to users or inherited through roles.

- **Direct Permissions**:
  - Assign: `$user->givePermissionTo('edit articles');`
  - Revoke: `$user->revokePermissionTo('edit articles');`
  - Sync: `$user->syncPermissions(['edit articles', 'delete articles']);`

- **Role Management**:
  - Assign Role: `$user->assignRole('writer');`
  - Remove Role: `$user->removeRole('writer');`
  - Sync Roles: `$user->syncRoles(['writer', 'admin']);`

### Checking Authorization
Since permissions are registered with Laravel's Gate, use standard Laravel methods:

- **Controller/Logic**: `$user->can('edit articles');`
- **Blade Templates**:
  - `@can('edit articles') ... @endcan`
  - `@role('admin') ... @endrole`
  - `@hasanyrole('writer|admin') ... @endhasanyrole`

## Artisan CLI Commands
Use the built-in Artisan commands for rapid environment setup and debugging:

- **Create a Role**: `php artisan permission:create-role admin`
- **Create a Permission**: `php artisan permission:create-permission "edit articles"`
- **Assign Role to User**: `php artisan permission:assign-role <username> <role>`
- **Clear Cache**: `php artisan permission:cache-reset` (Crucial after manual database changes to roles/permissions).

## Expert Tips & Best Practices

- **Prefer Roles over Direct Permissions**: For maintainability, group permissions into roles (e.g., "Editor") and assign the role to the user rather than individual permissions.
- **Middleware Protection**: Protect routes using the provided middleware in `app/Http/Kernel.php`:
  - `Route::group(['middleware' => ['role:admin']], function () { ... });`
  - `Route::group(['middleware' => ['permission:publish articles']], function () { ... });`
- **Super-Admin Bypass**: Use `Gate::before` in your `AuthServiceProvider` to grant all permissions to a "Super-Admin" role without explicitly assigning every permission:
  ```php
  Gate::before(function ($user, $ability) {
      return $user->hasRole('Super-Admin') ? true : null;
  });
  ```
- **Database Seeding**: Always use Seeders to define your initial permission set to ensure consistency across environments.



## Subcommands

| Command | Description |
|---------|-------------|
| perm | PerM (Periodic Seed Mapping) is a fast mapping program for short reads (e.g., Illumina, SOLiD) to a reference genome, using periodic seeds to improve sensitivity. |
| php artisan permission:create-permission | Create a new permission for the Spatie Laravel-permission package |

## Reference documentation
- [Associate users with permissions and roles](./references/github_com_spatie_laravel-permission.md)
- [Commit History and Command Updates](./references/github_com_spatie_laravel-permission_commits_main.md)