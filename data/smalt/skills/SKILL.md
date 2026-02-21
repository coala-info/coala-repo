---
name: smalt
description: Smalt (smalte) is a lightweight, high-performance template engine designed to bridge the gap between static configuration files and dynamic container environments.
homepage: https://github.com/roquie/smalte
---

# smalt

## Overview

Smalt (smalte) is a lightweight, high-performance template engine designed to bridge the gap between static configuration files and dynamic container environments. It allows you to define templates with standard environment variable placeholders and generate the final configuration at runtime. Unlike traditional tools like envsubst, smalte does not require awkward escaping of dollar signs in files that naturally use them (like Nginx or shell scripts) and provides granular control over which environment variables are processed through regex-based scoping.

## CLI Usage and Patterns

The primary command for the tool is `smalte build`.

### Basic Substitution
To replace environment variables in a template and output a new file:
`smalte build path/to/template.conf.tmpl:path/to/output.conf`

### Multiple File Processing
You can process multiple templates in a single command execution:
`smalte build template1.tmpl:config1.conf template2.tmpl:config2.conf`

### Scoped Variable Replacement
To prevent accidental substitution of variables not intended for the configuration, use the `--scope` flag. This limits smalte to only replace variables matching a specific prefix or regex:
`smalte build --scope NGINX_.* nginx.conf.tmpl:/etc/nginx/nginx.conf`

You can provide multiple scopes to include different sets of variables:
`smalte build --scope APP_ --scope DB_ template.tmpl:config.conf`

## Best Practices

### Template Naming
While not strictly required by the binary, use the `.tmpl` extension for your source files (e.g., `server.xml.tmpl`). This clearly distinguishes source templates from generated configuration files within your repository and Docker images.

### Docker Integration
The most effective way to use smalte is within a container's entrypoint script. This ensures configurations are generated fresh every time a container starts, allowing for runtime adjustments via environment variables.

Example entrypoint pattern:
1. Define default values using shell syntax: `export PORT=${PORT:=8080}`
2. Run smalte to generate the config: `smalte build config.tmpl:config.out`
3. Execute the main application process.

### Handling Special Characters
Unlike `envsubst`, smalte is designed to be "quiet" regarding variables it doesn't recognize or that aren't in scope. If a variable like `$uri` (common in Nginx) is present in the template but not defined in the system environment or included in the `--scope`, smalte will leave it untouched. This eliminates the need for workarounds like `${DOLLAR}uri`.

## Reference documentation
- [roquie/smalte](./references/github_com_roquie_smalte.md)