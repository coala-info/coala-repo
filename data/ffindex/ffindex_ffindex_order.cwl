cwlVersion: v1.2
class: CommandLineTool
baseCommand: ffindex_order
label: ffindex_ffindex_order
doc: "Reorder the entries of an ffindex into the order given in an order file.\n\nTool\
  \ homepage: https://github.com/soedinglab/ffindex_soedinglab"
inputs:
  - id: order_file
    type: File
    doc: Text file with the entry names in the wanted order, one per line
    inputBinding:
      position: 1
  - id: data_file
    type: File
    doc: Input ffindex data file
    inputBinding:
      position: 2
  - id: index_file
    type: File
    doc: Input ffindex index file
    inputBinding:
      position: 3
  - id: out_data_file
    type: string
    doc: Name of the reordered data file
    inputBinding:
      position: 4
  - id: out_index_file
    type: string
    doc: Name of the reordered index file
    inputBinding:
      position: 5
outputs:
  - id: sorted_data_file
    type: File
    doc: Reordered ffindex data file
    outputBinding:
      glob: $(inputs.out_data_file)
  - id: sorted_index_file
    type: File
    doc: Reordered ffindex index file
    outputBinding:
      glob: $(inputs.out_index_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ffindex:0.98--h9948957_5
