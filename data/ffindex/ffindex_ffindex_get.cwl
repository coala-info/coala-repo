cwlVersion: v1.2
class: CommandLineTool
baseCommand: ffindex_get
label: ffindex_ffindex_get
doc: "Retrieve entries from an ffindex by name (or by entry number with -n) and print\
  \ them. The index must be sorted.\n\nTool homepage: https://github.com/soedinglab/ffindex_soedinglab"
inputs:
  - id: data_file
    type: File
    doc: ffindex data file
    inputBinding:
      position: 1
  - id: index_file
    type: File
    doc: ffindex index file (sorted)
    inputBinding:
      position: 2
  - id: entry_names
    type:
      type: array
      items: string
    doc: Entry names to retrieve (entry numbers when use_index is set)
    inputBinding:
      position: 3
  - id: use_index
    type:
      - 'null'
      - boolean
    doc: use index of entry instead of entry name
    inputBinding:
      position: 0
      prefix: -n
outputs:
  - id: entries
    type: stdout
    doc: Contents of the requested entries
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ffindex:0.98--h9948957_5
stdout: ffindex_ffindex_get.out
