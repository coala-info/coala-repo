cwlVersion: v1.2
class: CommandLineTool
baseCommand: bedGraphPack
label: ucsc-bedgraphpack
doc: "Pack a bedGraph file into a more compact form.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: database
    type: string
    doc: The database name (e.g., hg19)
    inputBinding:
      position: 1
  - id: input_bedgraph
    type: File
    doc: Input bedGraph file
    inputBinding:
      position: 2
  - id: bed_format
    type:
      - 'null'
      - boolean
    doc: Output in bed format
    inputBinding:
      position: 103
      prefix: -bed
outputs:
  - id: output_bedgraphpack
    type: File
    doc: Output packed bedGraph file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bedgraphpack:482--h0b57e2e_0
