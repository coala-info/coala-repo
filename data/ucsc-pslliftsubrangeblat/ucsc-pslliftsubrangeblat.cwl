cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslLiftSubrangeBlat
label: ucsc-pslliftsubrangeblat
doc: "Lift PSL coordinates from a subrange BLAT run back to the original query coordinates.\n\
  \nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: q_start
    type: int
    doc: The start coordinate of the subrange in the query sequence.
    inputBinding:
      position: 1
  - id: q_end
    type: int
    doc: The end coordinate of the subrange in the query sequence.
    inputBinding:
      position: 2
  - id: in_psl
    type: File
    doc: Input PSL file from the subrange BLAT run.
    inputBinding:
      position: 3
outputs:
  - id: out_psl
    type: File
    doc: Output PSL file with coordinates lifted back to the original query.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-pslliftsubrangeblat:482--h0b57e2e_0
