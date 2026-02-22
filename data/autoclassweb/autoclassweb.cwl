cwlVersion: v1.2
class: CommandLineTool
baseCommand: autoclassweb
label: autoclassweb
doc: "The provided text does not contain help information or a description of the
  tool. It consists of system error messages related to container execution and disk
  space.\n\nTool homepage: https://github.com/pierrepo/autoclassweb"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/autoclassweb:v2.2.1_cv1
stdout: autoclassweb.out
