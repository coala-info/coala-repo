cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslScore
label: ucsc-pslscore
doc: "Calculate score for each PSL in file.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-pslscore:482--h0b57e2e_0
stdout: ucsc-pslscore.out
