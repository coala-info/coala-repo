cwlVersion: v1.2
class: CommandLineTool
baseCommand: emvc-2
label: emvc-2
doc: "EMVC-2 v1.0\n\nTool homepage: https://github.com/guilledufort/EMVC-2"
inputs:
  - id: bam_file
    type: File
    doc: The bam file
    inputBinding:
      position: 101
      prefix: --bam_file
  - id: bypass_dt
    type:
      - 'null'
      - boolean
    doc: Bypass Decision Tree filter
    inputBinding:
      position: 101
      prefix: --bypass_dt
  - id: iterations
    type:
      - 'null'
      - int
    doc: The number of EM iterations
    inputBinding:
      position: 101
      prefix: --iterations
  - id: learners
    type:
      - 'null'
      - int
    doc: The number of learners
    inputBinding:
      position: 101
      prefix: --learners
  - id: ref_file
    type: File
    doc: The reference fasta file
    inputBinding:
      position: 101
      prefix: --ref_file
  - id: threads
    type:
      - 'null'
      - int
    doc: The number of parallel threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - int
    doc: Make output verbose
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: out_file
    type: File
    doc: The output file name
    outputBinding:
      glob: $(inputs.out_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/emvc-2:1.0--h7b50bb2_4
