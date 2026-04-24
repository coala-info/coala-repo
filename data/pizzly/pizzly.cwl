cwlVersion: v1.2
class: CommandLineTool
baseCommand: pizzly
label: pizzly
doc: "A tool for fusion detection from kallisto alignments\n\nTool homepage: https://github.com/pmelsted/pizzly"
inputs:
  - id: align_score
    type:
      - 'null'
      - int
    doc: Maximum number of mismatches allowed
    inputBinding:
      position: 101
      prefix: --align-score
  - id: cache
    type:
      - 'null'
      - File
    doc: File for caching annotation (created if not present, otherwise reused from
      previous runs)
    inputBinding:
      position: 101
      prefix: --cache
  - id: fasta
    type:
      - 'null'
      - File
    doc: Fasta reference
    inputBinding:
      position: 101
      prefix: --fasta
  - id: gtf
    type:
      - 'null'
      - File
    doc: Annotation in GTF format
    inputBinding:
      position: 101
      prefix: --gtf
  - id: ignore_protein
    type:
      - 'null'
      - boolean
    doc: Ignore any protein coding information in annotation
    inputBinding:
      position: 101
      prefix: --ignore-protein
  - id: insert_size
    type:
      - 'null'
      - int
    doc: Maximum fragment size of library
    inputBinding:
      position: 101
      prefix: --insert-size
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: k-mer size used in kallisto
    inputBinding:
      position: 101
      prefix: -k
outputs:
  - id: output_prefix
    type:
      - 'null'
      - File
    doc: Prefix for output files
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pizzly:0.37.3--0
