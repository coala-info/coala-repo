cwlVersion: v1.2
class: CommandLineTool
baseCommand: phu simplify-taxa
label: phu_simplify-taxa
doc: "Simplify vContact taxonomy prediction columns into compact lineage codes.\n\n\
  Tool homepage: https://github.com/camilogarciabotero/phu"
inputs:
  - id: add_lineage
    type:
      - 'null'
      - boolean
    doc: Append compact_lineage column from deepest simplified rank
    inputBinding:
      position: 101
      prefix: --add-lineage
  - id: input_file
    type: File
    doc: Input vContact final_assignments.csv
    inputBinding:
      position: 101
      prefix: --input-file
  - id: lineage_col
    type:
      - 'null'
      - string
    doc: Name of the lineage column
    inputBinding:
      position: 101
      prefix: --lineage-col
  - id: sep
    type:
      - 'null'
      - string
    doc: "Override delimiter: ',' or '\\t'. Auto-detected from extension if not set"
    inputBinding:
      position: 101
      prefix: --sep
outputs:
  - id: output_file
    type: File
    doc: Output file path (.csv or .tsv)
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phu:0.4.4--pyhdfd78af_0
