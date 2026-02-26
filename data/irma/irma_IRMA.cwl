cwlVersion: v1.2
class: CommandLineTool
baseCommand: IRMA
label: irma_IRMA
doc: "Iterative Refinement Meta-Assembler (IRMA)\n\nTool homepage: https://wonder.cdc.gov/amd/flu/irma/"
inputs:
  - id: module_or_config
    type: string
    doc: MODULE or MODULE-CONFIG
    inputBinding:
      position: 1
  - id: fastq_gz_or_fastq
    type: File
    doc: fastq or fastq.gz (for single-end)
    inputBinding:
      position: 2
  - id: r1_fastq_gz_or_fastq
    type: File
    doc: R1.fastq.gz or R1.fastq (for paired-end)
    inputBinding:
      position: 3
  - id: r2_fastq_gz_or_fastq
    type:
      - 'null'
      - File
    doc: R2.fastq.gz or R2.fastq (for paired-end)
    inputBinding:
      position: 4
  - id: sample_name
    type: string
    doc: Sample name (optionally with path)
    inputBinding:
      position: 5
  - id: external_config
    type:
      - 'null'
      - string
    doc: Path to a valid configuration file
    inputBinding:
      position: 106
      prefix: --external-config
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/irma:1.2.0--pl5321hdfd78af_0
stdout: irma_IRMA.out
