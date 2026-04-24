cwlVersion: v1.2
class: CommandLineTool
baseCommand: minvar
label: minvar
doc: "optional arguments:\n\nTool homepage: https://git.io/minvar"
inputs:
  - id: fastq
    type: File
    doc: input reads in fastq format
    inputBinding:
      position: 101
      prefix: --fastq
  - id: keep
    type:
      - 'null'
      - boolean
    doc: keep intermediate files
    inputBinding:
      position: 101
      prefix: --keep
  - id: recal
    type:
      - 'null'
      - boolean
    doc: turn on recalibration with GATK
    inputBinding:
      position: 101
      prefix: --recal
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/minvar:2.2.2--py35_0
stdout: minvar.out
