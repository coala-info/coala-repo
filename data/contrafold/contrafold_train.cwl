cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - contrafold
  - train
label: contrafold_train
doc: "Train CONTRAfold models using provided sequence and structure data.\n\nTool
  homepage: http://contra.stanford.edu/contrafold/faq.html"
inputs:
  - id: filenames
    type:
      type: array
      items: File
    doc: Input training files (BPSEQ format with known structures)
    inputBinding:
      position: 200
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: show detailed console output
    inputBinding:
      position: 101
      prefix: --verbose
  - id: logbase
    type:
      - 'null'
      - float
    doc: set base of log-sum-exp
    inputBinding:
      position: 101
      prefix: --logbase
  - id: viterbi
    type:
      - 'null'
      - boolean
    doc: use Viterbi instead of posterior decoding for prediction, or max-margin 
      instead of log-likelihood for training
    inputBinding:
      position: 101
      prefix: --viterbi
  - id: noncomplementary
    type:
      - 'null'
      - boolean
    doc: allow non-{AU,CG,GU} pairs
    inputBinding:
      position: 101
      prefix: --noncomplementary
  - id: sanity
    type:
      - 'null'
      - boolean
    doc: perform gradient sanity check
    inputBinding:
      position: 101
      prefix: --sanity
  - id: holdout
    type:
      - 'null'
      - float
    doc: use fraction F of training data for holdout cross-validation
    inputBinding:
      position: 101
      prefix: --holdout
  - id: regularize
    type:
      - 'null'
      - float
    doc: perform BFGS training, using a single regularization coefficient C
    inputBinding:
      position: 101
      prefix: --regularize
outputs:
  - id: optimize_params
    type:
      - 'null'
      - File[]
    doc: Parameter files written during training (optimize.params.*)
    outputBinding:
      glob: optimize.params*
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/contrafold:2.02--h9948957_4
stdout: contrafold_train.out
