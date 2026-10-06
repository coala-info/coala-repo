cwlVersion: v1.2
class: CommandLineTool
baseCommand: [biasaway, k]
requirements:
  - class: InlineJavascriptRequirement
label: biasaway_k
doc: "k-mer shuffling generator: shuffle each foreground sequence keeping its k-mer composition\n\nTool\
  \ homepage: https://github.com/asntech/biasaway"
inputs:
  - id: foreground
    type: File
    doc: Foreground file in fasta format
    inputBinding:
      position: 1
      prefix: --foreground
  - id: kmer
    type:
      - 'null'
      - int
    doc: 'K-mer used for the shuffling (default: 2)'
    inputBinding:
      position: 1
      prefix: --kmer
  - id: nfold
    type:
      - 'null'
      - int
    doc: 'How many background sequences per each foreground sequence will be generated (default: 1)'
    inputBinding:
      position: 1
      prefix: --nfold
  - id: plot_filename
    type:
      - 'null'
      - string
    doc: 'Basename for the QC plot and metric files (default: no QC plot created)'
    inputBinding:
      position: 1
      prefix: --plot_filename
  - id: seed
    type:
      - 'null'
      - int
    doc: Seed number to initialize the random number generator
    inputBinding:
      position: 1
      prefix: --seed
outputs:
  - id: background_sequences
    type: stdout
    doc: Background sequences in fasta format
  - id: qc_plots
    type:
      - 'null'
      - File[]
    doc: QC plots (png) and metric files (txt)
    outputBinding:
      glob:
        - '$(inputs.plot_filename ? inputs.plot_filename + ''*.png'' : [])'
        - '$(inputs.plot_filename ? inputs.plot_filename + ''*.txt'' : [])'
stdout: $(inputs.foreground.nameroot)_background.fa
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biasaway:3.3.0--py_0
