cwlVersion: v1.2
class: CommandLineTool
baseCommand: diamond_test
label: diamond_test
doc: "The tool did not provide help text or a description. The output indicates an
  error when attempting to access help information.\n\nTool homepage: https://github.com/bbuchfink/diamond"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/diamond:2.1.21--h13889ed_0
stdout: diamond_test.out
