cwlVersion: v1.2
class: CommandLineTool
baseCommand: microbiomeutil-data
label: microbiomeutil-data
doc: 'Data utilities for the MicrobiomeUtil suite. (Note: The provided text contains
  container runtime error messages and does not list specific command-line arguments
  or usage instructions).'
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/microbiomeutil-data:v20101212dfsg1-2-deb_cv1
stdout: microbiomeutil-data.out
