cwlVersion: v1.2
class: CommandLineTool
baseCommand: differential_md_score
label: dastk_differential_md_score
doc: "Calculate differential MD-scores between two conditions using the DAStk (Differential
  ATAC-seq Toolkit).\n\nTool homepage: https://github.com/Dowell-Lab/DAStk"
inputs:
  - id: md_score_1
    type: File
    doc: MD-score file for the first condition.
    inputBinding:
      position: 1
  - id: md_score_2
    type: File
    doc: MD-score file for the second condition.
    inputBinding:
      position: 2
  - id: label_1
    type: string
    doc: Label for the first condition.
    inputBinding:
      position: 3
  - id: label_2
    type: string
    doc: Label for the second condition.
    inputBinding:
      position: 4
outputs:
  - id: output_prefix
    type:
      - 'null'
      - File
    doc: Prefix for the output files.
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dastk:1.0.1--pyh7cba7a3_0
