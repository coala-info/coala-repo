cwlVersion: v1.2
class: CommandLineTool
baseCommand: chainToPsl
label: ucsc-chaintopsl
doc: "Convert a chain file to a PSL format file.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: in_chain
    type: File
    doc: Input chain file
    inputBinding:
      position: 1
  - id: target_sizes
    type: File
    doc: Target chromosome sizes file
    inputBinding:
      position: 2
  - id: query_sizes
    type: File
    doc: Query chromosome sizes file
    inputBinding:
      position: 3
  - id: target_2bit
    type: File
    doc: Target 2bit file
    inputBinding:
      position: 4
  - id: query_2bit
    type: File
    doc: Query 2bit file
    inputBinding:
      position: 5
outputs:
  - id: out_psl
    type: File
    doc: Output PSL file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-chaintopsl:482--h0b57e2e_0
