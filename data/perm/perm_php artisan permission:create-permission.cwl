cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - php
  - artisan
  - permission:create-permission
label: perm_php artisan permission:create-permission
doc: "Create a new permission for the Spatie Laravel-permission package\n\nTool homepage:
  https://github.com/spatie/laravel-permission"
inputs:
  - id: name
    type: string
    doc: The name of the permission
    inputBinding:
      position: 1
  - id: guard
    type:
      - 'null'
      - string
    doc: The name of the guard (e.g., web, api)
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/perm:v0.4.0-4-deb_cv1
stdout: perm_php artisan permission:create-permission.out
