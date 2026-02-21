cwlVersion: v1.2
class: CommandLineTool
baseCommand: validators
label: validators
doc: "The provided text does not contain help information or usage instructions for
  the tool 'validators'. It appears to be a log of a failed container build or execution
  attempt.\n\nTool homepage: https://github.com/kvesteri/validators"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/validators:0.14.0--py_0
stdout: validators.out
