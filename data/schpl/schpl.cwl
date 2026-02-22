cwlVersion: v1.2
class: CommandLineTool
baseCommand: schpl
label: schpl
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log regarding a failed Singularity/Docker container pull due
  to insufficient disk space.\n\nTool homepage: https://github.com/lcmmichielsen/scHPL"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/schpl:1.0.5--pyhdfd78af_0
stdout: schpl.out
