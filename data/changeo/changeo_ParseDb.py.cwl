cwlVersion: v1.2
class: CommandLineTool
baseCommand: ParseDb.py
label: changeo_ParseDb.py
doc: "A utility to parse, filter, and manipulate Change-O tab-delimited database files.\n
  \nTool homepage: http://changeo.readthedocs.io"
inputs:
  - id: action
    type: string
    doc: 'Action to perform. One of: split, select, index, merge, rename, update,
      delete, drop, sort, subset.'
    inputBinding:
      position: 1
  - id: db_files
    type:
      type: array
      items: File
    doc: A list of Change-O formatted tab-delimited database files.
    inputBinding:
      position: 102
      prefix: -d
  - id: fields
    type:
      - 'null'
      - type: array
        items: string
    doc: The list of column names (fields) to use for the action.
    inputBinding:
      position: 102
      prefix: -f
  - id: logic
    type:
      - 'null'
      - string
    doc: Logic to use when multiple fields are specified (any or all).
    inputBinding:
      position: 102
      prefix: --logic
  - id: num
    type:
      - 'null'
      - int
    doc: Number of records to subset or sort.
    inputBinding:
      position: 102
      prefix: --num
  - id: outname
    type:
      - 'null'
      - string
    doc: User specified output file name.
    inputBinding:
      position: 102
      prefix: --outname
  - id: regex
    type:
      - 'null'
      - boolean
    doc: If specified, treat values as regular expressions.
    inputBinding:
      position: 102
      prefix: --regex
  - id: values
    type:
      - 'null'
      - type: array
        items: string
    doc: The list of values to use for selection or splitting.
    inputBinding:
      position: 102
      prefix: -u
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory.
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/changeo:1.3.4--pyhdfd78af_0
