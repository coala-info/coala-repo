---
name: perl-module-pluggable
description: This skill facilitates the implementation of modular Perl applications by leveraging `Module::Pluggable`.
homepage: http://metacpan.org/pod/Module::Pluggable
---

# perl-module-pluggable

## Overview
This skill facilitates the implementation of modular Perl applications by leveraging `Module::Pluggable`. It allows a base class to automatically detect and interact with "plugin" modules without hard-coding their names. This is particularly useful for applications requiring extensible metadata parsers, command handlers, or filter chains where new functionality should be added simply by dropping a new `.pm` file into a directory.

## Implementation Patterns

### Basic Plugin Discovery
To give a class the ability to find plugins in its own namespace (e.g., `MyClass::Plugin::*`):

```perl
package MyClass;
use Module::Pluggable;

# In your application code:
my $mc = MyClass->new();
my @plugins = $mc->plugins(); # Returns list of package names
```

### Automatic Loading and Instantiation
To automatically `require` the modules and call their constructors:

```perl
package MyClass;
# 'require => 1' loads the code; 'instantiate => "new"' calls the constructor
use Module::Pluggable 
    require     => 1, 
    instantiate => 'new';

# Usage:
# Arguments passed to plugins() are forwarded to the 'new' method of each plugin
my @plugin_objects = $self->plugins(@init_args);
```

### Customizing Search Paths
If plugins are located outside the default `Base::Plugin` namespace:

```perl
use Module::Pluggable 
    search_path => ['App::Extensions', 'External::Plugins'],
    sub_name    => 'get_extensions';
```

### Filtering Plugins
Use `only` or `except` to control which modules are loaded:

```perl
# Using a regex to exclude specific plugins
use Module::Pluggable except => qr/::Internal$/;

# Using an array ref for specific inclusion
use Module::Pluggable only => ['MyClass::Plugin::Active', 'MyClass::Plugin::Stable'];
```

## Expert Tips
- **Dynamic Loading**: `plugins()` rescans `@INC` every time it is called. If your plugin list is static, cache the results in a variable to improve performance.
- **Inner Packages**: By default, `Module::Pluggable` finds "inner packages" (multiple packages defined in one file). Disable this with `inner => 0` if you follow the one-package-per-file standard.
- **Safety Checks**: When iterating through plugins, always verify the plugin supports the expected interface using `can()`:
  ```perl
  foreach my $plugin ($self->plugins) {
      next unless $plugin->can('execute');
      $plugin->execute($data);
  }
  ```
- **Error Handling**: Use the `on_require_error` trigger to handle plugins that fail to compile without crashing the main application.

## Reference documentation
- [Module::Pluggable Documentation](./references/metacpan_org_pod_Module__Pluggable.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-module-pluggable_overview.md)