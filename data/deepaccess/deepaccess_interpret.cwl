cwlVersion: v1.2
class: CommandLineTool
baseCommand: deepaccess
label: deepaccess_interpret
doc: "Interpret deep learning models for DNA sequence analysis.\n\nTool homepage:
  https://github.com/gifford-lab/deepaccess-package"
inputs:
  - id: background
    type:
      - 'null'
      - string
    doc: Background model to use.
    inputBinding:
      position: 101
      prefix: --background
  - id: comparisons
    type:
      - 'null'
      - type: array
        items: string
    doc: List of comparisons.
    inputBinding:
      position: 101
      prefix: --comparisons
  - id: eval_motifs
    type:
      - 'null'
      - string
    doc: Evaluate motifs.
    inputBinding:
      position: 101
      prefix: --evalMotifs
  - id: eval_patterns
    type:
      - 'null'
      - string
    doc: Evaluate patterns.
    inputBinding:
      position: 101
      prefix: --evalPatterns
  - id: fastas
    type:
      - 'null'
      - type: array
        items: File
    doc: List of FASTA files.
    inputBinding:
      position: 101
      prefix: --fastas
  - id: labels
    type:
      - 'null'
      - type: array
        items: string
    doc: List of labels.
    inputBinding:
      position: 101
      prefix: --labels
  - id: make_vis
    type:
      - 'null'
      - boolean
    doc: Generate visualizations.
    inputBinding:
      position: 101
      prefix: --makeVis
  - id: position
    type:
      - 'null'
      - int
    doc: Position for analysis.
    inputBinding:
      position: 101
      prefix: --position
  - id: saliency
    type:
      - 'null'
      - boolean
    doc: Compute saliency maps.
    inputBinding:
      position: 101
      prefix: --saliency
  - id: subtract
    type:
      - 'null'
      - boolean
    doc: Subtract background signals.
    inputBinding:
      position: 101
      prefix: --subtract
  - id: train_dir
    type: Directory
    doc: Directory containing training data.
    inputBinding:
      position: 101
      prefix: --trainDir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepaccess:0.1.3--pyhdfd78af_0
stdout: deepaccess_interpret.out
