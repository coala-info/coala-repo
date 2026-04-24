cwlVersion: v1.2
class: CommandLineTool
baseCommand: downpore_consensus
label: downpore_consensus
doc: "Generates a consensus sequence from multiple input sequences using dynamic time
  warping.\n\nTool homepage: https://github.com/jteutenberg/downpore"
inputs:
  - id: input_sequences
    type:
      type: array
      items: File
    doc: One or more input sequence files (e.g., FASTA, FASTQ).
    inputBinding:
      position: 1
  - id: max_gap_extend
    type:
      - 'null'
      - int
    doc: Maximum length of gap extensions allowed in alignments.
    inputBinding:
      position: 102
      prefix: --max-gap-extend
  - id: max_gap_open
    type:
      - 'null'
      - int
    doc: Maximum number of gap openings allowed in alignments.
    inputBinding:
      position: 102
      prefix: --max-gap-open
  - id: min_score
    type:
      - 'null'
      - float
    doc: Minimum alignment score threshold for considering sequences.
    inputBinding:
      position: 102
      prefix: --min-score
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for computation.
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output for debugging.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Path to the output consensus sequence file.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/downpore:0.3.4--h375a9b1_0
