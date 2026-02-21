cwlVersion: v1.2
class: CommandLineTool
baseCommand: find_differential_primers
label: find_differential_primers
doc: "A tool for finding differential primers. (Note: The provided help text contains
  only system error messages and does not list specific usage instructions or arguments.)\n
  \nTool homepage: https://github.com/widdowquinn/find_differential_primers"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/find_differential_primers:0.1.4--py_0
stdout: find_differential_primers.out
