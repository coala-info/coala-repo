cwlVersion: v1.2
class: CommandLineTool
baseCommand: plmc
label: plmc
doc: "Inference of evolutionary couplings from multiple sequence alignments using
  pseudolikelihood maximization.\n\nTool homepage: https://github.com/debbiemarkslab/plmc"
inputs:
  - id: alignment_file
    type: File
    doc: Multiple sequence alignment in FASTA format
    inputBinding:
      position: 1
  - id: alphabet
    type:
      - 'null'
      - string
    doc: Alternative character set to use for analysis
    inputBinding:
      position: 102
      prefix: --alphabet
  - id: fast
    type:
      - 'null'
      - boolean
    doc: Fast weights and stochastic gradient descent
    inputBinding:
      position: 102
      prefix: --fast
  - id: focus
    type:
      - 'null'
      - string
    doc: Select only uppercase, non-gapped sites from a focus sequence
    inputBinding:
      position: 102
      prefix: --focus
  - id: gap_ignore
    type:
      - 'null'
      - boolean
    doc: Model sequence likelihoods only by coding, non-gapped portions
    inputBinding:
      position: 102
      prefix: --gapignore
  - id: lambda_e
    type:
      - 'null'
      - float
    doc: Set L2 lambda for couplings (e_ij)
    inputBinding:
      position: 102
      prefix: --lambdae
  - id: lambda_g
    type:
      - 'null'
      - float
    doc: Set group L1 lambda for couplings (e_ij)
    inputBinding:
      position: 102
      prefix: --lambdag
  - id: lambda_h
    type:
      - 'null'
      - float
    doc: Set L2 lambda for fields (h_i)
    inputBinding:
      position: 102
      prefix: --lambdah
  - id: max_iter
    type:
      - 'null'
      - int
    doc: Maximum number of iterations
    inputBinding:
      position: 102
      prefix: --maxiter
  - id: n_cores
    type:
      - 'null'
      - string
    doc: Maximum number of threads to use in OpenMP
    inputBinding:
      position: 102
      prefix: --ncores
  - id: scale
    type:
      - 'null'
      - float
    doc: 'Sequence weights: neighborhood weight [s > 0]'
    inputBinding:
      position: 102
      prefix: --scale
  - id: theta
    type:
      - 'null'
      - float
    doc: 'Sequence weights: neighborhood divergence [0 < t < 1]'
    inputBinding:
      position: 102
      prefix: --theta
  - id: weights_file
    type:
      - 'null'
      - File
    doc: Load sequence weights from file (one weight per line)
    inputBinding:
      position: 102
      prefix: --weights
outputs:
  - id: couplings_file
    type:
      - 'null'
      - File
    doc: Save coupling scores to file (text)
    outputBinding:
      glob: $(inputs.couplings_file)
  - id: output_param_file
    type:
      - 'null'
      - File
    doc: Save estimated parameters to file (binary)
    outputBinding:
      glob: $(inputs.output_param_file)
  - id: save_weights
    type:
      - 'null'
      - File
    doc: Save sequence weights to file (text)
    outputBinding:
      glob: $(inputs.save_weights)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plmc:20221105--hec16e2b_0
