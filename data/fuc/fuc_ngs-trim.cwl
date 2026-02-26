cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fuc
  - ngs-trim
label: fuc_ngs-trim
doc: "Pipeline for trimming adapters from FASTQ files.\n\nTool homepage: https://github.com/sbslee/fuc"
inputs:
  - id: manifest
    type: File
    doc: Sample manifest CSV file.
    inputBinding:
      position: 1
  - id: output
    type: Directory
    doc: Output directory.
    inputBinding:
      position: 2
  - id: qsub
    type: string
    doc: SGE resoruce to request for qsub.
    inputBinding:
      position: 3
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite the output directory if it already exists.
    inputBinding:
      position: 104
      prefix: --force
  - id: job
    type:
      - 'null'
      - string
    doc: Job submission ID for SGE.
    inputBinding:
      position: 104
      prefix: --job
  - id: thread
    type:
      - 'null'
      - int
    doc: Number of threads to use
    default: 1
    inputBinding:
      position: 104
      prefix: --thread
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
stdout: fuc_ngs-trim.out
