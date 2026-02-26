---
name: perl-moosex-singleton
description: This Perl module converts a Moose-based class into a singleton to ensure only one instance exists within an application. Use when user asks to create a singleton class, manage global configuration objects, or ensure a single shared instance of a Moose object.
homepage: https://github.com/moose/MooseX-Singleton
---


# perl-moosex-singleton

## Overview

MooseX::Singleton is a Perl module that converts a standard Moose-based class into a singleton, ensuring that only one instance of the class exists within an application. It is particularly useful for global configuration objects, database handles, or logging services where a shared state is required across different modules. By replacing the standard Moose import, the module injects specific methods for instance retrieval and controlled initialization.

## Implementation Guide

### Basic Usage
To convert a class, replace the standard `use Moose` statement with `use MooseX::Singleton`.

```perl
package MyApp::Config;
use MooseX::Singleton;

has 'api_key' => (
    is       => 'ro',
    isa      => 'Str',
    required => 1,
);

1;
```

### Accessing the Instance
The singleton instance is accessed via the `instance` method. If the instance does not exist, it is created using default values.

```perl
# In your application code
my $config = MyApp::Config->instance;
print $config->api_key;
```

### Controlled Initialization
If your singleton requires arguments for its attributes, you must call `initialize` before the first call to `instance`. Calling `initialize` more than once per class will result in an error.

```perl
# Initialize with specific values
MyApp::Config->initialize(api_key => 'secret_token_123');

# Subsequent calls to instance return the initialized object
my $config = MyApp::Config->instance;
```

## Expert Tips and Best Practices

*   **Avoid `new`**: While `new` currently acts as a hybrid of `initialize` and `instance`, it is slated for potential deprecation. Always prefer `instance` for retrieval and `initialize` for setup.
*   **Unit Testing**: Use the internal `_clear_instance` method in your test cleanup (e.g., in `tear_down` or `after` blocks) to ensure a fresh state between individual tests.
*   **Cooperation**: Since this module uses metaclass roles, it is compatible with most other `MooseX` extensions.
*   **Required Attributes**: If a singleton has `required` attributes without defaults, calling `instance` before `initialize` will cause the application to die. Always ensure global setup logic calls `initialize` during the application's bootstrap phase.

## Installation

The package can be installed via Conda from the Bioconda channel:

```bash
conda install bioconda::perl-moosex-singleton
```

## Reference documentation
- [MooseX::Singleton Overview](./references/github_com_moose_MooseX-Singleton.md)
- [Bioconda perl-moosex-singleton](./references/anaconda_org_channels_bioconda_packages_perl-moosex-singleton_overview.md)