cwlVersion: v1.2
class: CommandLineTool
baseCommand: bedRestrictToPositions
label: ucsc-bedrestricttopositions
doc: "Restrict BED features to positions in another BED file. Note: The provided input
  text was a system error log; this definition is based on the standard usage of the
  tool.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: in_bed
    type: File
    doc: Input BED file containing features to be restricted.
    inputBinding:
      position: 1
  - id: positions_bed
    type: File
    doc: BED file containing positions to restrict to.
    inputBinding:
      position: 2
outputs:
  - id: out_bed
    type: File
    doc: Output BED file.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bedrestricttopositions:482--h0b57e2e_0
