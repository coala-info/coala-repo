cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - php
  - artisan
  - permission:cache-reset
label: perm_php artisan permission:cache-reset
doc: "Reset the permission cache for the spatie/laravel-permission package\n\nTool
  homepage: https://github.com/spatie/laravel-permission"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/perm:v0.4.0-4-deb_cv1
stdout: perm_php artisan permission:cache-reset.out
