cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - deepaccess
  - train
label: deepaccess_train
doc: "Train a DeepAccess ensemble of convolutional neural networks for multi-task classification of DNA sequences.\n\nTool homepage: https://github.com/gifford-lab/deepaccess-package"
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
      - File
    doc: Text file with tab-delimited labels (0 or 1) for each FASTA sequence, 
      one column per class
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
    secondaryFiles:
      - pattern: .fai
        required: false
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
  - id: out_path
    type: string
    inputBinding:
      position: 102
      prefix: --out
outputs:
  - id: out
    type: Directory
    doc: Output directory for trained model and results
    outputBinding:
      glob: $(inputs.out_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepaccess:0.1.3--pyhdfd78af_0
