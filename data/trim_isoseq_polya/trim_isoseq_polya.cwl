cwlVersion: v1.2
class: CommandLineTool
baseCommand: trim_isoseq_polyA
label: trim_isoseq_polya
doc: "Trims the polyA tail from the 3-prime ends of FASTA sequences (Iso-seq) using an HMM.\n\nTool homepage: https://github.com/PacificBiosciences/trim_isoseq_polyA"
inputs:
  - id: input
    type: File
    doc: "The input fasta file with polyA, can be compressed by gzip or bzip2"
    inputBinding:
      position: 101
      prefix: --input
  - id: model
    type:
      - 'null'
      - File
    doc: "HMM model file to use; if not specified, will use default values"
    inputBinding:
      position: 101
      prefix: --model
  - id: polyA_training
    type:
      - 'null'
      - File
    doc: "Fasta file with polyA sequences for training with maximum-likelihood estimation"
    inputBinding:
      position: 101
      prefix: --polyA_training
  - id: non_polyA_training
    type:
      - 'null'
      - File
    doc: "Fasta file with non-polyA sequences for training with maximum-likelihood estimation"
    inputBinding:
      position: 101
      prefix: --non_polyA_training
  - id: new_model
    type:
      - 'null'
      - string
    doc: "New trained model file to output"
    inputBinding:
      position: 101
      prefix: --new_model
  - id: color
    type:
      - 'null'
      - boolean
    doc: "To color polyA sequences in the output instead of trimming away them"
    inputBinding:
      position: 101
      prefix: --color
  - id: thread
    type:
      - 'null'
      - int
    doc: "Number of threads to use (default 8)"
    inputBinding:
      position: 101
      prefix: --thread
  - id: generic
    type:
      - 'null'
      - boolean
    doc: "Input is generic fasta format; switches off the adjustment of header coordinates for Iso-seq input"
    inputBinding:
      position: 101
      prefix: --generic
outputs:
  - id: trimmed_fasta
    type: stdout
    doc: "Trimmed (or coloured) sequences in FASTA format"
  - id: new_model_file
    type:
      - 'null'
      - File
    doc: "Newly trained HMM model"
    outputBinding:
      glob: $(inputs.new_model)
stdout: trim_isoseq_polya.out
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/trim_isoseq_polya:0.0.3--h7c8eefc_0
