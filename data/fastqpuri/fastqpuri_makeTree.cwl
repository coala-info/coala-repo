cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastqpuri_makeTree
label: fastqpuri_makeTree
doc: "A tool from the FastqPuri suite, likely used for tree generation or related
  processing, though the provided help text contains only system error messages.\n
  \nTool homepage: https://github.com/jengelmann/FastqPuri"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastqpuri:1.0.7--r43h9d449c0_8
stdout: fastqpuri_makeTree.out
