cwlVersion: v1.2
class: CommandLineTool
baseCommand: chainSort
label: ucsc-chainsort
doc: "Sort chains. By default sorts by score. Note this loads all chains into memory,
  so it is not suitable for large sets. Instead, run chainSort on multiple small files,
  followed by chainMergeSort.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: in_file
    type: File
    doc: Input chain file
    inputBinding:
      position: 1
  - id: out_file
    type: string
    doc: Name of the output chain file
    inputBinding:
      position: 2
  - id: sort_target
    type: ['null', boolean]
    doc: Sort on target start rather than score
    inputBinding:
      position: 0
      prefix: -target
  - id: sort_query
    type: ['null', boolean]
    doc: Sort on query start rather than score
    inputBinding:
      position: 0
      prefix: -query
  - id: index
    type: ['null', string]
    doc: Name of a simple two column index file to build (<out file position> <value>,
      where value is score, target or query depending on the sort)
    inputBinding:
      position: 0
      prefix: -index=
      separate: false
outputs:
  - id: output_chain
    type: File
    doc: Sorted chain file
    outputBinding:
      glob: $(inputs.out_file)
  - id: output_index
    type: ['null', File]
    doc: Index file (when index is set)
    outputBinding:
      glob: $(inputs.index)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-chainsort:482--h0b57e2e_0
