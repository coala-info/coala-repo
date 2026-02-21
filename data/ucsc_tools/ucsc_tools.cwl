cwlVersion: v1.2
class: CommandLineTool
baseCommand: bedRestrictToPositions
label: ucsc_tools
doc: "A tool from the UCSC Genome Browser utilities (identified from container URI).
  Note: The provided text contains build logs and error messages rather than help
  text, so specific arguments could not be extracted.\n\nTool homepage: https://github.com/ropensci/UCSCXenaTools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bedrestricttopositions:482--h0b57e2e_0
stdout: ucsc_tools.out
