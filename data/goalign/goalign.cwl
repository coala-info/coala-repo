cwlVersion: v1.2
class: CommandLineTool
baseCommand: goalign
label: goalign
doc: "A tool for manipulating multiple alignments (Note: The provided text is a system
  error log and does not contain help information or argument definitions).\n\nTool
  homepage: https://github.com/fredericlemoine/goalign"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/goalign:0.4.0--h9ee0642_0
stdout: goalign.out
