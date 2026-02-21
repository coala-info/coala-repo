cwlVersion: v1.2
class: CommandLineTool
baseCommand: biasaway
label: biasaway
doc: "BiasAway is a tool for generating synthetic background sequences. (Note: The
  provided input text contains system error messages regarding a container build failure
  and does not include the actual help documentation for the tool's arguments.)\n\n
  Tool homepage: https://github.com/asntech/biasaway"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biasaway:3.3.0--py_0
stdout: biasaway.out
