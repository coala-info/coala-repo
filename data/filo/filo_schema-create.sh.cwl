cwlVersion: v1.2
class: CommandLineTool
baseCommand: filo_schema-create.sh
label: filo_schema-create.sh
doc: "A tool to create a schema for filo. (Note: The provided help text contains only
  system error messages regarding container image building and does not list specific
  arguments or usage instructions.)\n\nTool homepage: https://github.com/filodb/FiloDB"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/filo:v1.1.0-3b1-deb_cv1
stdout: filo_schema-create.sh.out
