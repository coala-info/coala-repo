cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslRecalcMatch
label: ucsc-pslrecalcmatch
doc: "Recalculate the match/mismatch counts of a PSL file using the actual sequences
  from .2bit files.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: in_psl
    type: File
    doc: Input PSL file.
    inputBinding:
      position: 1
  - id: query_2bit
    type: File
    doc: Query sequence file in .2bit format.
    inputBinding:
      position: 2
  - id: target_2bit
    type: File
    doc: Target sequence file in .2bit format.
    inputBinding:
      position: 3
outputs:
  - id: out_psl
    type: File
    doc: Output PSL file with recalculated statistics.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-pslrecalcmatch:482--h0b57e2e_0
