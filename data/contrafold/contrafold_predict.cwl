cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - contrafold
  - predict
label: contrafold_predict
doc: "Predict RNA secondary structures using the CONTRAfold algorithm.\n\nTool homepage:
  http://contra.stanford.edu/contrafold/faq.html"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: One or more input BPSEQ, plain text, or FASTA files for structure 
      prediction
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
  - id: params
    type:
      - 'null'
      - File
    doc: use particular model parameters
    inputBinding:
      position: 101
      prefix: --params
  - id: constraints
    type:
      - 'null'
      - boolean
    doc: use existing constraints (requires BPSEQ or FASTA format input)
    inputBinding:
      position: 101
      prefix: --constraints
  - id: gamma
    type:
      - 'null'
      - float
    doc: 'set sensivity/specificity tradeoff parameter (default: GAMMA=6); if GAMMA
      > 1, emphasize sensitivity; if 0 <= GAMMA <= 1, emphasize specificity; if GAMMA
      < 0, try tradeoff parameters of 2^k for k = -5,...,10'
    inputBinding:
      position: 101
      prefix: --gamma
  - id: parens
    type:
      - 'null'
      - string
    doc: write parenthesized output to file or directory
    inputBinding:
      position: 101
      prefix: --parens
  - id: bpseq
    type:
      - 'null'
      - string
    doc: write BPSEQ output to file or directory
    inputBinding:
      position: 101
      prefix: --bpseq
  - id: posteriors_cutoff
    type:
      - 'null'
      - float
    doc: write posterior pairing probabilities above this cutoff (use with 
      posteriors_out)
    inputBinding:
      position: 102
      prefix: --posteriors
  - id: posteriors_out
    type:
      - 'null'
      - string
    doc: file or directory for posterior pairing probabilities (use with 
      posteriors_cutoff)
    inputBinding:
      position: 103
  - id: partition
    type:
      - 'null'
      - boolean
    doc: compute the partition function or Viterbi score only
    inputBinding:
      position: 101
      prefix: --partition
outputs:
  - id: parens_out
    type:
      - 'null'
      - File
      - Directory
    doc: Parenthesized output file or directory
    outputBinding:
      glob: $(inputs.parens)
  - id: bpseq_out
    type:
      - 'null'
      - File
      - Directory
    doc: BPSEQ output file or directory
    outputBinding:
      glob: $(inputs.bpseq)
  - id: posteriors
    type:
      - 'null'
      - File
      - Directory
    doc: Posterior pairing probabilities file or directory
    outputBinding:
      glob: $(inputs.posteriors_out)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/contrafold:2.02--h9948957_4
stdout: contrafold_predict.out
