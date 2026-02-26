cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanosim-h
label: nanosim-h
doc: "A simulator for Oxford Nanopore reads (Note: The provided help text was a Docker
  error message; arguments below are based on standard tool usage).\n\nTool homepage:
  https://github.com/karel-brinda/NanoSim-H"
inputs:
  - id: max_len
    type:
      - 'null'
      - int
    doc: Maximum length of simulated reads
    inputBinding:
      position: 101
      prefix: -max
  - id: median_len
    type:
      - 'null'
      - float
    doc: Median length of simulated reads
    inputBinding:
      position: 101
      prefix: -med
  - id: min_len
    type:
      - 'null'
      - int
    doc: Minimum length of simulated reads
    inputBinding:
      position: 101
      prefix: -min
  - id: model_prefix
    type: string
    doc: The prefix of the trained model
    inputBinding:
      position: 101
      prefix: -c
  - id: number_of_reads
    type:
      - 'null'
      - int
    doc: Number of reads to be simulated
    inputBinding:
      position: 101
      prefix: -n
  - id: reference
    type: File
    doc: Reference genome in FASTA format
    inputBinding:
      position: 101
      prefix: -r
  - id: sd_len
    type:
      - 'null'
      - float
    doc: Standard deviation of read length
    inputBinding:
      position: 101
      prefix: -sd
outputs:
  - id: output_prefix
    type: File
    doc: The prefix of the output files
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanosim-h:1.1.0.4--pyr341h24bf2e0_0
