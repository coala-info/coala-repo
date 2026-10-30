cwlVersion: v1.2
class: CommandLineTool
baseCommand: merge_tsvs.py
label: wub_merge_tsvs.py
doc: "Merge tab separated files on a given field using pandas.\n\nTool homepage: https://github.com/nanoporetech/wub"
inputs:
  - id: join
    type:
      - 'null'
      - string
    doc: "Join type (outer)."
    inputBinding:
      position: 1
      prefix: -j
  - id: field
    type:
      - 'null'
      - string
    doc: "Join on this field (Read)."
    inputBinding:
      position: 2
      prefix: -f
  - id: out_tsv
    type:
      - 'null'
      - string
    doc: "Output tsv (merge_tsvs.tsv)."
    inputBinding:
      position: 3
      prefix: -o
  - id: fill_zero
    type:
      - 'null'
      - boolean
    doc: "Fill NA values with zero."
    inputBinding:
      position: 4
      prefix: -z
  - id: input_tsvs
    type:
      type: array
      items: File
    doc: "Input tab separated files."
    inputBinding:
      position: 100
outputs:
  - id: merged_tsv
    type: File
    doc: "Merged table"
    outputBinding:
      glob: '${ return inputs.out_tsv ? inputs.out_tsv : "merge_tsvs.tsv"; }'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
