cwlVersion: v1.2
class: CommandLineTool
baseCommand: stark
label: stark
doc: "v1.0\n\nTool homepage: https://github.com/hnikaein/stark"
inputs:
  - id: input_file
    type: File
    doc: use FILE for input
    inputBinding:
      position: 101
      prefix: --input
  - id: log_level
    type:
      - 'null'
      - string
    doc: use LEVEL for log level (0=OFF, 1000=ALL)
    inputBinding:
      position: 101
      prefix: --log
  - id: merge_type
    type:
      - 'null'
      - string
    doc: use TYPE for merging (0=no merge, 1=only node reducing merges, 2=all 
      merges)
    inputBinding:
      position: 101
      prefix: --merge-type
  - id: statistics_level
    type:
      - 'null'
      - string
    doc: print statistics (0=no statistics, 1=trivial statistics, 
      2=cpu-consuming statistics)
    inputBinding:
      position: 101
      prefix: --statistics
  - id: unify_before_run
    type:
      - 'null'
      - boolean
    doc: unify input file unitigs before use
    inputBinding:
      position: 101
      prefix: --unify-before-run
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: use FILE for output
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stark:0.1.1--h9f5acd7_3
