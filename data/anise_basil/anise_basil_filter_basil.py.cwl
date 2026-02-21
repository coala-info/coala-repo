cwlVersion: v1.2
class: CommandLineTool
baseCommand: filter_basil.py
label: anise_basil_filter_basil.py
doc: "Filter BASIL output VCF.\n\nTool homepage: https://github.com/seqan/anise_basil"
inputs:
  - id: in_file_name
    type: File
    doc: Input file name.
    inputBinding:
      position: 101
      prefix: -i
  - id: min_clipping_each_side
    type:
      - 'null'
      - int
    doc: Minimal OEA coverage on each side.
    inputBinding:
      position: 101
      prefix: --min-clipping-each-side
  - id: min_clipping_sum
    type:
      - 'null'
      - int
    doc: Minimal total OEA coverage.
    inputBinding:
      position: 101
      prefix: --min-clipping-sum
  - id: min_gscore
    type:
      - 'null'
      - float
    doc: Smallest geometric mean score
    inputBinding:
      position: 101
      prefix: --min-gscore
  - id: min_oea_each_side
    type:
      - 'null'
      - int
    doc: Minimal OEA coverage on each side.
    inputBinding:
      position: 101
      prefix: --min-oea-each-side
  - id: min_oea_one_side
    type:
      - 'null'
      - int
    doc: Minimal OEA coverage on one side.
    inputBinding:
      position: 101
      prefix: --min-oea-one-side
  - id: min_oea_sum
    type:
      - 'null'
      - int
    doc: Minimal total OEA coverage.
    inputBinding:
      position: 101
      prefix: --min-oea-sum
outputs:
  - id: out_file_name
    type: File
    doc: Output file name.
    outputBinding:
      glob: $(inputs.out_file_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/anise_basil:1.2.0--py312hdcc493e_9
