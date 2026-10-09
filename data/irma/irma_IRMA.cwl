cwlVersion: v1.2
class: CommandLineTool
baseCommand: IRMA
label: irma_IRMA
doc: "Iterative Refinement Meta-Assembler (IRMA)\n\nTool homepage: https://wonder.cdc.gov/amd/flu/irma/"
inputs:
  - id: module_or_config
    type: string
    doc: MODULE (for example FLU, FLU-avian, FLU-utr, FLU-pacbio, CoV, EBOLA, RSV) or MODULE-CONFIG
    inputBinding:
      position: 1
  - id: reads_1
    type: File
    doc: R1.fastq.gz or R1.fastq for paired-end, or the single fastq or fastq.gz file for single-end
    inputBinding:
      position: 2
  - id: reads_2
    type:
      - 'null'
      - File
    doc: R2.fastq.gz or R2.fastq (paired-end only)
    inputBinding:
      position: 3
  - id: sample_name
    type: string
    doc: Sample name (optionally with path). IRMA writes its results into a directory with this name.
    inputBinding:
      position: 4
  - id: external_config
    type:
      - 'null'
      - File
    doc: Path to a valid configuration file
    inputBinding:
      position: 5
      prefix: --external-config
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: results_directory
    type: Directory
    doc: IRMA results directory (consensus, amended consensus, tables, logs)
    outputBinding:
      glob: $(inputs.sample_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/irma:1.2.0--pl5321hdfd78af_0
stdout: irma_IRMA.out
