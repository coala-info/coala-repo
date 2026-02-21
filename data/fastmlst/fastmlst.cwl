cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastmlst
label: fastmlst
doc: "A tool for fast Multilocus Sequence Typing (MLST). Note: The provided help text
  contains only system error messages regarding container execution and does not list
  available command-line arguments.\n\nTool homepage: https://github.com/EnzoAndree/FastMLST"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastmlst:0.0.19--pyhdfd78af_0
stdout: fastmlst.out
