cwlVersion: v1.2
class: CommandLineTool
baseCommand: cladeomatic
label: cladeomatic
doc: "The provided text does not contain help information or usage instructions; it
  is a system error log indicating a failure to build or extract a container image
  due to insufficient disk space.\n\nTool homepage: https://github.com/phac-nml/cladeomatic"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cladeomatic:0.1.1--pyhdfd78af_0
stdout: cladeomatic.out
