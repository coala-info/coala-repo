cwlVersion: v1.2
class: CommandLineTool
baseCommand: deepaccess
label: deepaccess_train
doc: "Train a deep learning model for variant calling.\n\nTool homepage: https://github.com/gifford-lab/deepaccess-package"
inputs:
  - id: bedfiles
    type:
      - 'null'
      - type: array
        items: File
    doc: BED files for training data
    inputBinding:
      position: 101
      prefix: --bedfiles
  - id: fasta
    type:
      - 'null'
      - File
    doc: FASTA file for training data
    inputBinding:
      position: 101
      prefix: --fasta
  - id: fasta_labels
    type:
      - 'null'
      - type: array
        items: string
    doc: Labels corresponding to FASTA files
    inputBinding:
      position: 101
      prefix: --fasta_labels
  - id: frac_random
    type:
      - 'null'
      - float
    doc: Fraction of random samples to use for training
    inputBinding:
      position: 101
      prefix: --frac_random
  - id: genome
    type:
      - 'null'
      - File
    doc: genome chrom.sizes file
    inputBinding:
      position: 101
      prefix: --genome
  - id: holdout
    type:
      - 'null'
      - string
    doc: chromosome to holdout
    inputBinding:
      position: 101
      prefix: --holdout
  - id: labels
    type:
      type: array
      items: string
    doc: Labels for training data
    inputBinding:
      position: 101
      prefix: --labels
  - id: nepochs
    type:
      - 'null'
      - int
    doc: Number of training epochs
    inputBinding:
      position: 101
      prefix: --nepochs
  - id: ref_fasta
    type:
      - 'null'
      - File
    doc: Reference FASTA file
    inputBinding:
      position: 101
      prefix: --refFasta
  - id: seed
    type:
      - 'null'
      - int
    doc: Random seed for reproducibility
    inputBinding:
      position: 101
      prefix: --seed
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print training progress
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: out
    type: File
    doc: Output directory for trained model and results
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepaccess:0.1.3--pyhdfd78af_0
