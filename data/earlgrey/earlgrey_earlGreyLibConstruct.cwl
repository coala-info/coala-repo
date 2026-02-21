cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - earlGreyLibConstruct
label: earlgrey_earlGreyLibConstruct
doc: "A tool for Transposable Element (TE) annotation and library construction. (Note:
  The provided help text contained system error messages regarding container image
  building and did not include usage instructions or argument definitions.)\n\nTool
  homepage: https://github.com/TobyBaril/EarlGrey"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/earlgrey:7.0.1--h9948957_1
stdout: earlgrey_earlGreyLibConstruct.out
