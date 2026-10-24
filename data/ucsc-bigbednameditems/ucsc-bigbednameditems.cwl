cwlVersion: v1.2
class: CommandLineTool
baseCommand: bigBedNamedItems
label: ucsc-bigbednameditems
doc: "Extract item of given name from bigBed\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: big_bed
    type: File
    doc: The input bigBed file (it needs an index on the searched field).
    inputBinding:
      position: 1
  - id: name
    type: string
    doc: A name to look up, or a file of space delimited names when name_file is set.
    inputBinding:
      position: 2
  - id: output_bed
    type: string
    doc: Name of the output BED file
    inputBinding:
      position: 3
  - id: name_file
    type:
      - 'null'
      - boolean
    doc: If set, treat the name parameter as a file full of space delimited names.
    inputBinding:
      position: 101
      prefix: -nameFile
  - id: field
    type:
      - 'null'
      - string
    doc: Use index on field name, default is "name".
    inputBinding:
      position: 101
      prefix: -field=
      separate: false
  - id: header
    type:
      - 'null'
      - boolean
    doc: Output an autoSql-style header (starts with '#').
    inputBinding:
      position: 101
      prefix: -header
outputs:
  - id: out_output_bed
    type: File
    doc: BED file with the matching items
    outputBinding:
      glob: $(inputs.output_bed)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bigbednameditems:482--h0b57e2e_0
