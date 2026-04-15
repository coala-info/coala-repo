---
name: smalt
description: Smalt is a minimalist template engine that renders environment variables into configuration files for containerized environments. Use when user asks to render templates, inject environment variables into config files, or scope variables using regex to avoid accidental collisions.
homepage: https://github.com/roquie/smalte
metadata:
  docker_image: "biocontainers/smalt:v0.7.6-8-deb_cv1"
---

# smalt

## Overview

Smalte is a minimalist template engine written in Nim, designed specifically for containerized environments. It solves the problem of "static configuration" by allowing you to define templates with environment variable placeholders (e.g., `$PORT` or `$DB_HOST`) and rendering them into final configuration files during the container startup process. Unlike standard tools like `envsubst`, Smalte provides regex-based variable scoping and avoids the need for ugly escaping hacks for variables that should remain literal (like `$uri` in Nginx).

## CLI Usage and Patterns

### Basic Template Rendering
The primary command is `build`, which uses a `source:destination` syntax.

```bash
smalte build /etc/nginx/nginx.conf.tmpl:/etc/nginx/nginx.conf
```

### Processing Multiple Files
You can process multiple templates in a single execution by appending more pairs.

```bash
smalte build \
    config/app.tmpl:config/app.conf \
    config/db.tmpl:config/db.conf
```

### Scoping Environment Variables
To prevent accidental collisions or to limit which variables are injected, use the `--scope` flag. This supports regular expressions.

*   **Single Prefix**: Only inject variables starting with `APP_`.
    ```bash
    smalte build --scope "APP_.*" template.tmpl:config.conf
    ```
*   **Multiple Scopes**: Include specific prefixes or exact matches.
    ```bash
    smalte build --scope "NGINX_.*" --scope "PORT" --scope "DB_HOST" \
        nginx.tmpl:nginx.conf
    ```

## Best Practices

### Docker Entrypoint Integration
The most effective way to use Smalte is within a `start.sh` or `entrypoint.sh` script. Define your defaults using shell parameter expansion before calling Smalte.

```bash
#!/usr/bin/env sh
# Set defaults if not provided by docker run -e
export PORT=${PORT:=8080}
export WORKERS=${WORKERS:=4}

# Build the config
smalte build --scope "PORT" --scope "WORKERS" \
    /templates/service.conf.tmpl:/etc/service/service.conf

# Execute the main process
exec service-binary
```

### Handling Nginx and System Variables
One of Smalte's main advantages over `envsubst` is that it doesn't require escaping system variables like `$uri` or `$host` if they aren't in your defined scope. 
*   If you do **not** include `uri` in your `--scope`, Smalte will leave `$uri` untouched in your Nginx config.
*   This eliminates the need for `${DOLLAR}uri` workarounds.

### Binary Installation in Docker
To keep images slim, use a multi-stage build or copy the binary directly from the official image.

```dockerfile
# Copy from the official alpine-based image
COPY --from=roquie/smalte:latest-alpine /app/smalte /usr/local/bin/smalte
```

## Expert Tips
*   **Binary Size**: The compiled binary is extremely small (~200kb), making it faster to load and more secure (smaller attack surface) than installing heavy template engines like Jinja2 or Gomplate in a minimal container.
*   **Missing Variables**: By default, Smalte is safer than `envsubst`. If a variable is referenced in a template but not found in the environment (and not filtered out by scope), Smalte typically leaves the placeholder as-is rather than replacing it with an empty string, preventing broken configurations.
*   **Regex Precision**: When using `--scope`, remember to escape dots if you want literal matches (e.g., `API\.KEY\..*`).



## Subcommands

| Command | Description |
|---------|-------------|
| smalt_index | Index a reference genome for SMALT alignment. |
| smalt_map | Map reads to an index |
| smalt_sample | Sample reads from query files based on an index. |

## Reference documentation
- [Smalte README](./references/github_com_roquie_smalte_blob_master_README.md)
- [Makefile Build Patterns](./references/github_com_roquie_smalte_blob_master_Makefile.md)