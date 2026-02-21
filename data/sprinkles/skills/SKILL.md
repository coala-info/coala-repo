---
name: sprinkles
description: Sprinkle is a lightweight software provisioning tool that uses a Ruby-based Domain Specific Language (DSL) to define how servers should be configured.
homepage: https://github.com/sprinkle-tool/sprinkle
---

# sprinkles

## Overview
Sprinkle is a lightweight software provisioning tool that uses a Ruby-based Domain Specific Language (DSL) to define how servers should be configured. Unlike more complex configuration management systems, Sprinkle focuses on a "package-policy-deployment" workflow. You define what software exists (packages), which servers need which software (policies), and how the commands are delivered to the target (deployment). It is particularly effective for developers who prefer a programmatic, Ruby-centric approach to infrastructure as code without the overhead of a master-client architecture.

## Core DSL Components

### 1. Packages
Packages define the individual units of software. Each package specifies an installer (apt, gem, source, etc.), dependencies, and a verification block.

```ruby
package :nginx do
  description 'Nginx Web Server'
  apt 'nginx'
  requires :build_essential
  
  verify do
    has_executable '/usr/sbin/nginx'
    has_process 'nginx'
  end
end
```

### 2. Policies
Policies map packages to specific server roles.

```ruby
policy :webserver, :roles => :app do
  requires :nginx
  requires :ruby_stack
end
```

### 3. Deployment
The deployment block configures the transport mechanism (Capistrano, Vlad, net/ssh, or local) and global defaults.

```ruby
deployment do
  delivery :capistrano do
    recipes 'deploy'
  end

  source do
    prefix   '/usr/local'
    archives '/usr/local/sources'
    builds   '/usr/local/build'
  end
end
```

## Common Installer Types
Sprinkle supports various installers to provide flexibility:
- **apt**: For Debian/Ubuntu packages.
- **gem**: For RubyGems.
- **source**: For compiling from source (supports `configure`, `make`, and `make install` patterns).
- **deb**: For installing local `.deb` files.
- **rpm**: For RedHat-based systems.
- **local**: For running local commands or transferring files.

## Verification Best Practices
Always include a `verify` block in your packages. Sprinkle uses these to determine if a package is already installed, preventing redundant operations and providing a "dry-run" capability.
- `has_file '/path/to/file'`
- `has_directory '/path/to/dir'`
- `has_executable '/usr/bin/ruby'`
- `has_process 'mysql'`
- `has_gem 'rails', '7.0.0'`
- `runs_without_error 'command'`

## Expert Tips and CLI Patterns

### Running Sprinkle
Execute your provisioning script using the `sprinkle` command:
```bash
sprinkle -s install_script.rb
```

### Virtual Packages
Use the `:provides` option to create virtual packages. This allows you to require a category (like `:database`) and choose the specific implementation (like `:mysql` or `:postgresql`) at runtime or via policy.
```ruby
package :mysql, :provides => :database do
  apt 'mysql-server'
end
```

### Handling Sudo
If your deployment requires root privileges, ensure your delivery method is configured for sudo. For the `net/ssh` delivery, you can often specify `user` and `password` or rely on SSH keys with passwordless sudo configured on the target.

### Local Provisioning
To provision the machine you are currently on, use the local delivery method:
```ruby
deployment do
  delivery :local
end
```

## Reference documentation
- [Sprinkle README](./references/github_com_sprinkle-tool_sprinkle.md)
- [Sprinkle Wiki](./references/github_com_sprinkle-tool_sprinkle_wiki.md)