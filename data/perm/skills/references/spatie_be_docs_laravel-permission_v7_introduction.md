[SPATIE](/ "Home")

Menu

---

* [Products](https://spatie.be/products)
* [Open Source](https://spatie.be/open-source)
* [Courses](https://spatie.be/courses)
* [Web Development](https://spatie.be/web-development)

[About](https://spatie.be/about-us)[Blog](https://spatie.be/blog)[Newsletter](https://spatie.be/newsletter)[Docs](https://spatie.be/docs)[Guidelines](https://spatie.be/guidelines)[Merch ↗](https://spatie.myspreadshop.net)[Log in](https://spatie.be/login)

SPATIE

# Laravel Permission

spatie.be/open-source

[Docs](https://spatie.be/docs)

[Laravel-permission](https://spatie.be/docs/laravel-permission/v7)

Introduction

Version

v7

v6

v5

v4

v3

Other versions for crawler
[v7](https://spatie.be/docs/laravel-permission/v7)
[v6](https://spatie.be/docs/laravel-permission/v6)
[v5](https://spatie.be/docs/laravel-permission/v5)
[v4](https://spatie.be/docs/laravel-permission/v4)
[v3](https://spatie.be/docs/laravel-permission/v3)

* [Introduction](https://spatie.be/docs/laravel-permission/v7/introduction)
* [Support us](https://spatie.be/docs/laravel-permission/v7/support-us)
* [Prerequisites](https://spatie.be/docs/laravel-permission/v7/prerequisites)
* [Installation in Laravel](https://spatie.be/docs/laravel-permission/v7/installation-laravel)
* [Upgrading](https://spatie.be/docs/laravel-permission/v7/upgrading)
* [Questions and issues](https://spatie.be/docs/laravel-permission/v7/questions-issues)
* [Changelog](https://spatie.be/docs/laravel-permission/v7/changelog)
* [About us](https://spatie.be/docs/laravel-permission/v7/about-us)

## Basic Usage

* [Basic Usage](https://spatie.be/docs/laravel-permission/v7/basic-usage/basic-usage)
* [Direct Permissions](https://spatie.be/docs/laravel-permission/v7/basic-usage/direct-permissions)
* [Using Permissions via Roles](https://spatie.be/docs/laravel-permission/v7/basic-usage/role-permissions)
* [Enums](https://spatie.be/docs/laravel-permission/v7/basic-usage/enums)
* [Teams permissions](https://spatie.be/docs/laravel-permission/v7/basic-usage/teams-permissions)
* [Wildcard permissions](https://spatie.be/docs/laravel-permission/v7/basic-usage/wildcard-permissions)
* [Blade directives](https://spatie.be/docs/laravel-permission/v7/basic-usage/blade-directives)
* [Defining a Super-Admin](https://spatie.be/docs/laravel-permission/v7/basic-usage/super-admin)
* [Using multiple guards](https://spatie.be/docs/laravel-permission/v7/basic-usage/multiple-guards)
* [Artisan Commands](https://spatie.be/docs/laravel-permission/v7/basic-usage/artisan)
* [Middleware](https://spatie.be/docs/laravel-permission/v7/basic-usage/middleware)
* [Passport Client Credentials Grant usage](https://spatie.be/docs/laravel-permission/v7/basic-usage/passport)
* [Example App](https://spatie.be/docs/laravel-permission/v7/basic-usage/new-app)

## Best Practices

* [Roles vs Permissions](https://spatie.be/docs/laravel-permission/v7/best-practices/roles-vs-permissions)
* [Model Policies](https://spatie.be/docs/laravel-permission/v7/best-practices/using-policies)
* [Performance Tips](https://spatie.be/docs/laravel-permission/v7/best-practices/performance)

## Advanced usage

* [Testing](https://spatie.be/docs/laravel-permission/v7/advanced-usage/testing)
* [Database Seeding](https://spatie.be/docs/laravel-permission/v7/advanced-usage/seeding)
* [Exceptions](https://spatie.be/docs/laravel-permission/v7/advanced-usage/exceptions)
* [Extending](https://spatie.be/docs/laravel-permission/v7/advanced-usage/extending)
* [Cache](https://spatie.be/docs/laravel-permission/v7/advanced-usage/cache)
* [Events](https://spatie.be/docs/laravel-permission/v7/advanced-usage/events)
* [Custom Permission Check](https://spatie.be/docs/laravel-permission/v7/advanced-usage/custom-permission-check)
* [UUID/ULID](https://spatie.be/docs/laravel-permission/v7/advanced-usage/uuid)
* [PhpStorm Interaction](https://spatie.be/docs/laravel-permission/v7/advanced-usage/phpstorm)
* [Other](https://spatie.be/docs/laravel-permission/v7/advanced-usage/other)
* [Timestamps](https://spatie.be/docs/laravel-permission/v7/advanced-usage/timestamps)
* [UI Options](https://spatie.be/docs/laravel-permission/v7/advanced-usage/ui-options)

# Laravel Permission

## Associate users with roles and permissions

Use this package to easily add permissions or roles to users in your Laravel app.

[Repository](https://github.com/spatie/laravel-permission)

[Open Issues](https://github.com/spatie/laravel-permission/issues)

89,807,837

12,859

## Introduction

This package allows you to manage user permissions and roles in a database.

Once installed you can do stuff like this:

```
// Adding permissions to a user
$user->givePermissionTo('edit articles');

// Adding permissions via a role
$user->assignRole('writer');

$role->givePermissionTo('edit articles');
```

If you're using multiple guards we've got you covered as well. Every guard will have its own set of permissions and roles that can be assigned to the guard's users. Read about it in the [using multiple guards](./basic-usage/multiple-guards/) section.

Because all permissions will be registered on [Laravel's gate](https://laravel.com/docs/authorization), you can check if a user has a permission with Laravel's default `can` function:

```
$user->can('edit articles');
```

and Blade directives:

```
@can('edit articles')
...
@endcan
```

[About us](https://spatie.be/docs/laravel-permission/v7/about-us)

[Support us](https://spatie.be/docs/laravel-permission/v7/support-us)

[Help us improve this page](https://github.com/spatie/laravel-permission/blob/main/docs/introduction.md)

Copy as markdown
Copied!

Medialibrary.pro

UI components for the Media Library

[Learn more](https://medialibrary.pro?ref=spatie-docs)

[Help us improve this page](https://github.com/spatie/laravel-permission/blob/main/docs/introduction.md)

* [Products](https://spatie.be/products)
* [Open Source](https://spatie.be/open-source)
* [Courses](https://spatie.be/courses)
* [Web Development](https://spatie.be/web-development)

[About](https://spatie.be/about-us)[Blog](https://spatie.be/blog)[Newsletter](https://spatie.be/newsletter)[Docs](https://spatie.be/docs)[Guidelines](https://spatie.be/guidelines)[Merch ↗](https://spatie.myspreadshop.net)[Log in](https://spatie.be/login)

---

[Kruikstraat 22, Box 12

2018 Antwerp, Belgium](https://goo.gl/maps/A2zoLK3nVF9V8jydA)

info@spatie.be

[+32 3 292 56 79](#tel)

* [GitHub](https://github.com/spatie)
* [Instagram](https://www.instagram.com/spatie_be)
* [LinkedIn](https://be.linkedin.com/company/spatie)
* [Twitter](https://twitter.com/spatie_be)
* [Bluesky](https://bsky.app/profile/spatie.be)
* [Mastodon](https://phpc.social/%40spatie)
* [YouTube](https://www.youtube.com/channel/UCoBbei3S9JLTcS2VeEOWDeQ)

* [Privacy](https://spatie.be/privacy)
* [Disclaimer](https://spatie.be/disclaimer)

+32 3 292 56 79

Our office is closed now, email us instead

ESC

Enter a search term to find results in the documentation.