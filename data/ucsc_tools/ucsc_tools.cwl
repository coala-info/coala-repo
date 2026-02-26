cwlVersion: v1.2
class: CommandLineTool
baseCommand: bedRestrictToPositions
label: ucsc_tools
doc: Restrict BED features to specific positions.
inputs:
  - id: input_bed
    type: File
    doc: Input BED file containing features to be restricted.
    inputBinding:
      position: 1
  - id: positions_bed
    type: File
    doc: BED file containing positions to restrict features to.
    inputBinding:
      position: 2
outputs:
  - id: output_bed
    type: File
    doc: Output BED file.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/ucsc-bedrestricttopositions:482--h0b57e2e_0
