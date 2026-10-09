cwlVersion: v1.2
class: CommandLineTool
baseCommand: gkmtrain-svr
label: ls-gkm_gkmtrain-svr
doc: "Train a support vector regression (SVR) model with the gapped k-mer kernel from a table of sequences and scores.\n\nTool homepage: https://github.com/Dongwon-Lee/lsgkm"
inputs:
  - id: datafile
    type: File
    doc: 'Tab-delimited data file; the 1st column is the sequence and the 2nd column is the score'
    inputBinding:
      position: 1
  - id: outprefix
    type: string
    doc: 'Prefix of output files <outprefix>.model.txt or <outprefix>.cvpred.txt'
    inputBinding:
      position: 2
  - id: kernel_type
    type:
      - 'null'
      - int
    doc: 'Set kernel function: 0 gapped-kmer, 1 estimated l-mer with full filter, 2 gkm (default), 3 gkmrbf, 4 wgkm, 5 wgkmrbf'
    inputBinding:
      position: 103
      prefix: -t
  - id: word_length
    type:
      - 'null'
      - int
    doc: 'Set word length, 3<=l<=12 (default: 11)'
    inputBinding:
      position: 103
      prefix: -l
  - id: informative_columns
    type:
      - 'null'
      - int
    doc: 'Set number of informative column, k<=l (default: 7)'
    inputBinding:
      position: 103
      prefix: -k
  - id: max_mismatches
    type:
      - 'null'
      - int
    doc: 'Set maximum number of mismatches to consider, d<=4 (default: 3)'
    inputBinding:
      position: 103
      prefix: -d
  - id: rbf_gamma
    type:
      - 'null'
      - float
    doc: 'Set gamma for RBF kernel; -t 3 or 5 only (default: 1.0)'
    inputBinding:
      position: 103
      prefix: -g
  - id: initial_weight
    type:
      - 'null'
      - int
    doc: 'Set the initial value (M) of the exponential decay function for wgkm kernels, max 255; -t 4 or 5 only (default: 50)'
    inputBinding:
      position: 103
      prefix: -M
  - id: half_life
    type:
      - 'null'
      - float
    doc: 'Set the half-life parameter (H) for wgkm kernels; -t 4 or 5 only (default: 50)'
    inputBinding:
      position: 103
      prefix: -H
  - id: no_reverse_complement
    type:
      - 'null'
      - boolean
    doc: 'If set, reverse-complement is not considered as the same feature'
    inputBinding:
      position: 103
      prefix: -R
  - id: svr_c
    type:
      - 'null'
      - float
    doc: 'Set the regularization parameter C (default: 0.1)'
    inputBinding:
      position: 103
      prefix: -c
  - id: svr_epsilon
    type:
      - 'null'
      - float
    doc: 'Set the epsilon parameter in the loss function of SVR (default: 0.1)'
    inputBinding:
      position: 103
      prefix: -p
  - id: shrinking
    type:
      - 'null'
      - boolean
    doc: 'If set, use the shrinking heuristics'
    inputBinding:
      position: 103
      prefix: -s
  - id: cv_folds
    type:
      - 'null'
      - int
    doc: 'Set N-fold cross validation mode (default: no cross validation)'
    inputBinding:
      position: 103
      prefix: -x
  - id: cv_run_index
    type:
      - 'null'
      - int
    doc: 'Run i-th cross validation only, 1<=i<=ncv (default: all)'
    inputBinding:
      position: 103
      prefix: -i
  - id: random_seed
    type:
      - 'null'
      - int
    doc: 'Set random seed for shuffling in cross validation mode (default: 1)'
    inputBinding:
      position: 103
      prefix: -r
  - id: verbosity
    type:
      - 'null'
      - int
    doc: 'Set the level of verbosity, 0 to 4 (default: 2)'
    inputBinding:
      position: 103
      prefix: -v
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Set the number of threads for parallel calculation: 1, 4, or 16 (default: 1)'
    inputBinding:
      position: 103
      prefix: -T
  - id: cache_memory
    type:
      - 'null'
      - float
    doc: 'Set cache memory size in MB (default: 100.0)'
    inputBinding:
      position: 103
      prefix: -m
  - id: epsilon
    type:
      - 'null'
      - float
    doc: 'Set the precision parameter epsilon (default: 0.001)'
    inputBinding:
      position: 103
      prefix: -e
outputs:
  - id: model_file
    type:
      - 'null'
      - File
    doc: Trained model, written when cross validation is not used
    outputBinding:
      glob: $(inputs.outprefix).model.txt
  - id: cvpred_file
    type:
      - 'null'
      - File
    doc: Cross-validation predictions, written in cross validation mode
    outputBinding:
      glob: $(inputs.outprefix).cvpred.txt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ls-gkm:0.1.1--h9948957_0
