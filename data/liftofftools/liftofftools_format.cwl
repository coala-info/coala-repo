cwlVersion: v1.2
class: CommandLineTool
baseCommand: liftofftools
label: liftofftools_format
doc: "liftofftools: error: argument subcommand: invalid choice: 'format' (choose from
  'clusters', 'variants', 'synteny', 'all')\n\nTool homepage: https://github.com/agshumate/LiftoffTools"
inputs:
  - id: subcommand
    type: string
    doc: subcommand (choose from 'clusters', 'variants', 'synteny', 'all')
    inputBinding:
      position: 1
  - id: c
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: -c
  - id: dir
    type:
      - 'null'
      - Directory
    doc: DIR
    inputBinding:
      position: 102
      prefix: --dir
  - id: edit_distance
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --edit-distance
  - id: f
    type:
      - 'null'
      - string
    doc: F
    inputBinding:
      position: 102
      prefix: -f
  - id: force
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --force
  - id: infer_genes
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --infer-genes
  - id: mmseqs_params
    type:
      - 'null'
      - string
    doc: STR
    inputBinding:
      position: 102
      prefix: --mmseqs_params
  - id: mmseqs_path
    type:
      - 'null'
      - string
    doc: MMSEQS_PATH
    inputBinding:
      position: 102
      prefix: --mmseqs_path
  - id: r
    type: string
    doc: R
    inputBinding:
      position: 102
      prefix: -r
  - id: r_sort
    type:
      - 'null'
      - string
    doc: R_SORT
    inputBinding:
      position: 102
      prefix: --r-sort
  - id: rg
    type: string
    doc: GFF/GTF or DB
    inputBinding:
      position: 102
      prefix: -rg
  - id: t
    type: string
    doc: T
    inputBinding:
      position: 102
      prefix: -t
  - id: t_sort
    type:
      - 'null'
      - string
    doc: T_SORT
    inputBinding:
      position: 102
      prefix: --t-sort
  - id: tg
    type: string
    doc: GFF/GTF or DB
    inputBinding:
      position: 102
      prefix: -tg
  - id: v
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: -V
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/liftofftools:0.4.4--pyhdfd78af_0
stdout: liftofftools_format.out
