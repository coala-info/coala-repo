cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslSelect
label: ucsc-pslselect
doc: "Select records from a PSL file. A selection option must be given.\n\nTool homepage:
  https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: in_psl
    type: File
    doc: Input PSL file.
    inputBinding:
      position: 10
  - id: out_psl
    type: string
    doc: Output PSL file name.
    inputBinding:
      position: 11
  - id: qt_pairs
    type:
      - 'null'
      - File
    doc: File of tab-separated qName and tName pairs to select.
    inputBinding:
      position: 1
      prefix: -qtPairs=
      separate: false
  - id: q_pass
    type:
      - 'null'
      - boolean
    doc: Pass all PSLs with queries that do not appear in the qtPairs file at all
      (default is to remove all PSLs for queries that are not in the file).
    inputBinding:
      position: 2
      prefix: -qPass
  - id: queries
    type:
      - 'null'
      - File
    doc: File with qNames to select.
    inputBinding:
      position: 3
      prefix: -queries=
      separate: false
  - id: query_pairs
    type:
      - 'null'
      - File
    doc: File of tab-separated pairs of qNames to select, with the new qName to
      substitute in the output file.
    inputBinding:
      position: 4
      prefix: -queryPairs=
      separate: false
  - id: qt_start
    type:
      - 'null'
      - File
    doc: File of tab-separated rows of qName, tName, tStart.
    inputBinding:
      position: 5
      prefix: -qtStart=
      separate: false
  - id: q_delim
    type:
      - 'null'
      - string
    doc: Use only the part of the query name before this character.
    inputBinding:
      position: 6
      prefix: -qDelim=
      separate: false
outputs:
  - id: out_psl_file
    type: File
    doc: Output PSL file with the selected records.
    outputBinding:
      glob: $(inputs.out_psl)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-pslselect:482--h0b57e2e_0
