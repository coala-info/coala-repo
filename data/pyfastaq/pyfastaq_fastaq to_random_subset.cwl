cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pyfastaq
  - fastaq
  - to_random_subset
label: pyfastaq_fastaq to_random_subset
doc: "Select a random subset of sequences from a FASTA file.\n\nTool homepage: https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: input_file
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 1
  - id: fraction_of_sequences
    type:
      - 'null'
      - float
    doc: Fraction of sequences to select (0.0 to 1.0)
    inputBinding:
      position: 102
      prefix: --fraction
  - id: number_of_sequences
    type:
      - 'null'
      - int
    doc: Number of sequences to select
    inputBinding:
      position: 102
      prefix: --number
  - id: seed
    type:
      - 'null'
      - int
    doc: Random seed for reproducibility
    inputBinding:
      position: 102
      prefix: --seed
outputs:
  - id: output_file
    type: File
    doc: Output FASTA file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
