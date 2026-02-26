cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanomonsv insert_classify
label: nanomonsv_insert_classify
doc: "Classify SVs based on LINE1 insertion\n\nTool homepage: https://github.com/friend1ws/nanomonsv"
inputs:
  - id: sv_list_file
    type: File
    doc: Path to nanomonsv get result file
    inputBinding:
      position: 1
  - id: reference_fa
    type: File
    doc: Path to the reference genome sequence
    inputBinding:
      position: 2
  - id: gencode_gtf_gz
    type: File
    doc: Path to GFT file for transcript
    inputBinding:
      position: 3
  - id: line1_db
    type: File
    doc: Path to LINE1 position file
    inputBinding:
      position: 4
  - id: debug
    type:
      - 'null'
      - boolean
    doc: keep intermediate files
    inputBinding:
      position: 105
      prefix: --debug
outputs:
  - id: output_file
    type: File
    doc: Path to output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanomonsv:0.8.1--pyhdfd78af_0
