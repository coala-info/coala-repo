cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslSomeRecords
label: ucsc-pslsomerecords
doc: "Extract PSL records from a file that match a list of names.\n\nTool homepage:
  http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs:
  - id: psl_in
    type: File
    doc: Input PSL file
    inputBinding:
      position: 1
  - id: list_file
    type: File
    doc: File containing the list of names to match
    inputBinding:
      position: 2
  - id: not_in_list
    type:
      - 'null'
      - boolean
    doc: Output records NOT in the list
    inputBinding:
      position: 103
      prefix: -not
  - id: query_names
    type:
      - 'null'
      - boolean
    doc: List is of query names (default)
    inputBinding:
      position: 103
      prefix: -i
  - id: target_names
    type:
      - 'null'
      - boolean
    doc: List is of target names
    inputBinding:
      position: 103
      prefix: -t
outputs:
  - id: psl_out
    type: File
    doc: Output PSL file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-pslsomerecords:482--h0b57e2e_0
