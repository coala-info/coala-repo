cwlVersion: v1.2
class: CommandLineTool
baseCommand: hifieval_hifieval.py
label: hifieval_hifieval.py
doc: "HIFI-eval is a tool for evaluating the quality of HiFi reads.\n\nTool homepage:
  https://github.com/magspho/hifieval"
inputs:
  - id: bam_input
    type:
      - 'null'
      - boolean
    doc: Input is in BAM format
    inputBinding:
      position: 101
      prefix: -b
  - id: coverage_threshold
    type:
      - 'null'
      - int
    doc: Coverage threshold for evaluation
    inputBinding:
      position: 101
      prefix: -c
  - id: reads_file
    type:
      - 'null'
      - File
    doc: Input reads FASTA/FASTQ file
    inputBinding:
      position: 101
      prefix: -r
  - id: reference_genome
    type:
      - 'null'
      - File
    doc: Reference genome FASTA file
    inputBinding:
      position: 101
      prefix: -h
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file for results
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hifieval:0.4.0--pyh7cba7a3_0
