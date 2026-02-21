---
name: perl-moosex-object-pluggable
description: `MooseX::Object::Pluggable` is a Perl module designed to add a flexible plugin system to Moose-based classes.
homepage: https://github.com/moose/MooseX-Object-Pluggable
---

# perl-moosex-object-pluggable

## Overview
`MooseX::Object::Pluggable` is a Perl module designed to add a flexible plugin system to Moose-based classes. Unlike standard role consumption which happens at compile-time, this module allows you to load and apply roles (plugins) to specific *instances* of a class at runtime. This is ideal for applications where functionality needs to be extended based on configuration or user input without affecting all instances of the base class.

## Basic Implementation
To make a class pluggable, consume the `MooseX::Object::Pluggable` role within your Moose class:

```perl
package MyApp;
use Moose;
with 'MooseX::Object::Pluggable';
```

## Creating Plugins
Plugins are standard Moose roles. By default, the module looks for them in the `Plugin` sub-namespace of your application (e.g., `MyApp::Plugin::*`).

```perl
package MyApp::Plugin::Pretty;
use Moose::Role;

sub pretty_print {
    my $self = shift;
    print "Executing pretty_print in " . $self->_original_class_name;
}
1;
```

## Loading Plugins
You can load plugins dynamically on an instance of your class.

- **`load_plugin($name)`**: Loads a single plugin.
- **`load_plugins(@names)`**: Loads multiple plugins at once.

```perl
my $app = MyApp->new;

# Loads MyApp::Plugin::Pretty
$app->load_plugin('Pretty');

# Loads a plugin from a fully qualified namespace using the '+' prefix
$app->load_plugin('+External::Library::Role');

$app->pretty_print;
```

## Managing Namespaces
You can control where the tool searches for plugins by adjusting internal attributes:

- **`_plugin_ns`**: The sub-namespace to append to the application name (Default: `Plugin`).
- **`_plugin_app_ns`**: An array reference of base namespaces to search. By default, this includes the class name and its precedents. This allows subclasses to use plugins from their parent's namespace while prioritizing their own.

```perl
# Example: Changing the plugin directory to MyApp::Extensions::*
has '+_plugin_ns' => ( default => 'Extensions' );
```

## Expert Tips and Caveats
- **Anonymous Classes**: When a role is applied at runtime, Moose creates an anonymous class. Consequently, `ref $self`, `blessed($self)`, and `$self->meta->name` will return the name of the anonymous class rather than your original class. Use the attribute **`_original_class_name`** to access the name of the class as it was at instantiation.
- **Method Modifiers**: Plugins can use `before`, `after`, and `around` modifiers. Be mindful of the load order, as plugins applied later will wrap the methods of the class (and previously loaded plugins).
- **Avoid `override`**: Do not use `override` in plugins. It is closely linked to inheritance and often fails to work as expected in multiple-role runtime applications. Use `around` instead.
- **Attribute Constraints**: Because roles are applied at runtime, they lose the ability to wrap `BUILD` methods. Additionally, attributes defined in these roles using `has` may not trigger compile-time checks like `required` or `default` in the same way as standard roles.
- **Namespace Collisions**: If two namespaces in `_plugin_app_ns` contain a plugin with the same name, the one appearing first in the array takes precedence.

## Reference documentation
- [MooseX-Object-Pluggable GitHub README](./references/github_com_moose_MooseX-Object-Pluggable.md)