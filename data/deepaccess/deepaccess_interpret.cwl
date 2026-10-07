cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - deepaccess
  - interpret
label: deepaccess_interpret
doc: "Interpret deep learning models for DNA sequence analysis.\n\nTool homepage:
  https://github.com/gifford-lab/deepaccess-package"
inputs:
  - id: background
    type:
      - 'null'
      - File
    doc: 'FASTA file containing background sequences (default: the packaged
      backgrounds.fa)'
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
      - File
    doc: PWM or PCM database of DNA sequence motifs to evaluate
    inputBinding:
      position: 101
      prefix: --evalMotifs
  - id: eval_patterns
    type:
      - 'null'
      - File
    doc: FASTA file containing DNA sequence patterns to evaluate
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
    doc: Directory containing the trained DeepAccess model (results are 
      written into it)
    inputBinding:
      position: 101
      prefix: --trainDir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: results_dir
    type: Directory
    doc: The model directory with the interpretation results added 
      (predictions, EPE/DEPE tables, saliency files and plots)
    outputBinding:
      glob: $(inputs.train_dir.basename)
  - id: interpretation_files
    type:
      type: array
      items: File
    doc: EPE/DEPE tables (<trainDir>_EPE_*.txt) and saliency files and plots 
      (<trainDir>_*-saliency*), written beside the model directory
    outputBinding:
      glob: $(inputs.train_dir.basename)_*
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.train_dir)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepaccess:0.1.3--pyhdfd78af_0
stdout: deepaccess_interpret.out
