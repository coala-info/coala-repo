cwlVersion: v1.2
class: CommandLineTool
baseCommand: raremetalworker
label: raremetalworker
doc: The provided text does not contain help information or a description of the tool.
  It appears to be a container execution error log.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/raremetalworker:v4.13.7_cv3
stdout: raremetalworker.out
