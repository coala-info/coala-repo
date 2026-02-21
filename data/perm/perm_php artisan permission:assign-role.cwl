cwlVersion: v1.2
class: CommandLineTool
baseCommand: perm
label: perm_php artisan permission:assign-role
doc: "A tool for mapping short reads to a reference genome (inferred from the container
  image biocontainers/perm). Note: The provided text is an error log from a container
  build process and does not contain standard help text or argument definitions.\n
  \nTool homepage: https://github.com/spatie/laravel-permission"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/perm:v0.4.0-4-deb_cv1
stdout: perm_php artisan permission:assign-role.out
