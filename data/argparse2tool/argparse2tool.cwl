cwlVersion: v1.2
class: CommandLineTool
baseCommand: argparse2tool
label: argparse2tool
doc: "A tool to automatically generate Galaxy tool wrappers or CWL tool descriptions
  from Python programs using argparse.\n\nTool homepage: https://github.com/erasche/argparse2tool"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/argparse2tool:0.5.2--pyhdfd78af_0
stdout: argparse2tool.out
