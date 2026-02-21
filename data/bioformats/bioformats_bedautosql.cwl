cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bioformats
  - bedautosql
label: bioformats_bedautosql
doc: "Get an autoSql table structure for the specified BED file\n\nTool homepage:
  https://github.com/gtamazian/bioformats"
inputs:
  - id: bed_file
    type: File
    doc: a BED file
    inputBinding:
      position: 1
  - id: description
    type:
      - 'null'
      - string
    doc: a table description
    default: Description
    inputBinding:
      position: 102
      prefix: --description
  - id: lines
    type:
      - 'null'
      - int
    doc: the number of lines to analyzefrom the input file
    default: 100
    inputBinding:
      position: 102
      prefix: --lines
  - id: name
    type:
      - 'null'
      - string
    doc: a table name
    default: Table
    inputBinding:
      position: 102
      prefix: --name
outputs:
  - id: output_file
    type: File
    doc: an output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bioformats:0.1.15--py27_0
