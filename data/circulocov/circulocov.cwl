cwlVersion: v1.2
class: CommandLineTool
baseCommand: circulocov
label: circulocov
doc: "A tool for circular genome coverage analysis. (Note: The provided input text
  is a container execution error log and does not contain help documentation or argument
  definitions.)\n\nTool homepage: https://github.com/erinyoung/CirculoCov"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/circulocov:0.1.20240104--pyhdfd78af_0
stdout: circulocov.out
