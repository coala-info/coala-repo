cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqlike
label: seqlike
doc: "A tool for sequence manipulation and analysis (Note: The provided text is a
  system error log and does not contain usage instructions or argument definitions).\n
  \nTool homepage: https://pypi.org/project/seqlike/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqlike:1.1.6--pyh5e36f6f_0
stdout: seqlike.out
