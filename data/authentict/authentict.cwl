cwlVersion: v1.2
class: CommandLineTool
baseCommand: authentict
label: authentict
doc: "AuthentiCT: a tool for estimating contamination in ancient DNA sequences using
  deamination patterns.\n\nTool homepage: https://github.com/StephanePeyregne/AuthentiCT"
inputs:
  - id: subcommand
    type: string
    doc: Subcommand to run (e.g., run, train)
    inputBinding:
      position: 1
  - id: bam_file
    type: File
    doc: Input BAM file containing the alignments
    inputBinding:
      position: 102
      prefix: --bam
  - id: model_file
    type:
      - 'null'
      - File
    doc: Path to a pre-trained model file
    inputBinding:
      position: 102
      prefix: --model
  - id: num_reads
    type:
      - 'null'
      - int
    doc: Number of reads to sample from the BAM file
    inputBinding:
      position: 102
      prefix: --n-reads
  - id: read_length
    type:
      - 'null'
      - int
    doc: Maximum read length to consider
    inputBinding:
      position: 102
      prefix: --read-length
  - id: vcf_file
    type: File
    doc: Input VCF file containing the variants
    inputBinding:
      position: 102
      prefix: --vcf
outputs:
  - id: output_prefix
    type:
      - 'null'
      - File
    doc: Prefix for the output files
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/authentict:1.0.1--py311h9f5acd7_0
