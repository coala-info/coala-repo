cwlVersion: v1.2
class: CommandLineTool
baseCommand: pgscatalog-relabel
label: pgscatalog.core_pgscatalog-relabel
doc: "Relabel the column values in one file based on a pair of columns in another\n\
  \nTool homepage: https://github.com/PGScatalog/pygscatalog/"
inputs:
  - id: col_from
    type: string
    doc: column to change FROM
    inputBinding:
      position: 101
      prefix: --col_from
  - id: col_to
    type: string
    doc: column to change TO
    inputBinding:
      position: 101
      prefix: --col_to
  - id: combined
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --combined
  - id: comment_char
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --comment_char
  - id: dataset
    type: string
    doc: Label for target genomic dataset
    inputBinding:
      position: 101
      prefix: --dataset
  - id: map_files
    type:
      type: array
      items: File
    doc: mapping filenames
    inputBinding:
      position: 101
      prefix: --maps
  - id: outdir
    type: Directory
    doc: output directory
    inputBinding:
      position: 101
      prefix: --outdir
  - id: split
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --split
  - id: target_col
    type: string
    doc: target column to revalue
    inputBinding:
      position: 101
      prefix: --target_col
  - id: target_file
    type: File
    doc: target file
    inputBinding:
      position: 101
      prefix: --target_file
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Extra logging information
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pgscatalog.core:1.0.2--pyhdfd78af_0
stdout: pgscatalog.core_pgscatalog-relabel.out
