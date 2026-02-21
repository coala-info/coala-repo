cwlVersion: v1.2
class: CommandLineTool
baseCommand: genform
label: genform
doc: "A tool for generating molecular formulas. (Note: The provided text contains
  system error messages regarding container image retrieval and does not include specific
  usage instructions or argument definitions.)\n\nTool homepage: https://sourceforge.net/projects/genform/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genform:r8--h9948957_8
stdout: genform.out
