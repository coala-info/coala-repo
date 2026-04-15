---
name: perl-moosex-app
description: MooseX::App is a framework for building complex, multi-command command-line interfaces using Moose. Use when user asks to create CLI tools with subcommands, define command-line flags as class attributes, or generate automatic documentation for Perl utilities.
homepage: http://metacpan.org/pod/MooseX::App
metadata:
  docker_image: "quay.io/biocontainers/perl-moosex-app:1.3701--pl526_0"
---

# perl-moosex-app

## Overview
MooseX::App is a framework for building complex, multi-command CLI tools by leveraging the power of Moose. It allows developers to treat CLI commands as objects, where each command is a separate class and command-line flags are defined as class attributes. This approach promotes code reuse, type safety, and automatic documentation generation, making it ideal for creating professional-grade Perl utilities with minimal boilerplate.

## Core Implementation Patterns

### Application Entry Point
The main script should initialize the application by calling `new_with_options`.

```perl
#!/usr/bin/env perl
use strict;
use warnings;
use My::App;

My::App->new_with_options->initialize;
```

### Base Application Class
Define the base class to search for commands in a specific namespace.

```perl
package My::App;
use MooseX::App qw(Config Color); # Load plugins

# Global options go here
option 'verbose' => (
    is            => 'rw',
    isa           => 'Bool',
    documentation => 'Enable verbose output',
);

1;
```

### Defining Commands
Each command is a class under the application's namespace (e.g., `My::App::Command::Run`).

```perl
package My::App::Command::Run;
use MooseX::App::Command; # Required for commands
extends 'My::App';

parameter 'input_file' => (
    is            => 'ro',
    isa           => 'Str',
    required      => 1,
    documentation => 'Path to the input file',
);

option 'retries' => (
    is            => 'rw',
    isa           => 'Int',
    default       => 3,
    short_nm      => 'r',
    documentation => 'Number of retry attempts',
);

sub execute {
    my ($self) = @_;
    # Command logic goes here
}

1;
```

## Best Practices
- **Attribute Documentation**: Always provide the `documentation` key for options and parameters; MooseX::App uses this to generate the `--help` output automatically.
- **Type Constraints**: Use Moose type constraints (`Int`, `Bool`, `Str`, `File`) to ensure CLI input is validated before the `execute` method runs.
- **Namespacing**: Keep commands in the `Command` sub-namespace of your app to allow the automatic command discovery feature to work efficiently.
- **Plugins**: Utilize built-in plugins like `Color` for better UI, `Config` for reading options from files, and `Depends` for handling option dependencies.
- **Short Names**: Use `short_nm` to provide single-letter aliases (e.g., `-v` for `--verbose`) to improve user experience.

## Reference documentation
- [MooseX::App Documentation](./references/metacpan_org_pod_MooseX__App.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-moosex-app_overview.md)