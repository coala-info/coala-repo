cwlVersion: v1.2
class: CommandLineTool
baseCommand: consensusfixer
label: consensusfixer
doc: "ConsensusFixer is a tool designed to compute a consensus sequence from a BAM
  file and a reference FASTA file, taking into account various parameters like minimum
  coverage and frequency thresholds.\n\nTool homepage: https://github.com/cbg-ethz/ConsensusFixer"
inputs:
  - id: input_bam
    type: File
    doc: Input BAM file containing the alignments.
    inputBinding:
      position: 101
      prefix: --input
  - id: min_coverage
    type:
      - 'null'
      - int
    doc: Minimum coverage required to call a base in the consensus.
    inputBinding:
      position: 101
      prefix: --min-cov
  - id: reference_fasta
    type: File
    doc: Reference FASTA file used for the alignments.
    inputBinding:
      position: 101
      prefix: --ref
  - id: threshold
    type:
      - 'null'
      - float
    doc: Frequency threshold for calling a base in the consensus.
    inputBinding:
      position: 101
      prefix: --threshold
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output for debugging and detailed logging.
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Output directory where the consensus sequence and related files will be
      written.
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/consensusfixer:0.4--2
