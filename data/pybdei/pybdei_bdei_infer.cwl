cwlVersion: v1.2
class: CommandLineTool
baseCommand: bdei_infer
label: pybdei_bdei_infer
doc: "BDEI model parameter inference from phylogenetic trees.\n\nTool homepage: https://github.com/evolbioinfo/bdei"
inputs:
  - id: ci_repetitions
    type:
      - 'null'
      - int
    doc: Number of repetitions for CI calculation (the higher, the more precise 
      but also longer; a typical value is 100). If not specified, CIs will not 
      be calculated.
    inputBinding:
      position: 101
      prefix: --CI_repetitions
  - id: la
    type:
      - 'null'
      - float
    doc: Value to fix BDEI transmission rate lambda. If not given, will be 
      estimated.
    inputBinding:
      position: 101
      prefix: --la
  - id: log_level
    type:
      - 'null'
      - int
    doc: 'level of logging information (the lower, the less information will be printed
      to the output). Possible levels are: 0 (errors only), 1 (errors+warnings), 2
      (errors+warnings+info), 3 (errors+warnings+info+debug).'
    inputBinding:
      position: 101
      prefix: --log_level
  - id: mu
    type:
      - 'null'
      - float
    doc: Value to fix BDEI becoming-infectious rate mu. If not given, will be 
      estimated.
    inputBinding:
      position: 101
      prefix: --mu
  - id: nwk
    type: File
    doc: Input tree(s) in newick format (must be rooted).
    inputBinding:
      position: 101
      prefix: --nwk
  - id: p
    type:
      - 'null'
      - float
    doc: Value to fix BDEI sampling probability. If not given, will be 
      estimated.
    inputBinding:
      position: 101
      prefix: --p
  - id: pi_e
    type:
      - 'null'
      - float
    doc: Frequency of E at time 0, should be between 0 and 1. If not given, will
      be estimated from the model parameters.
    inputBinding:
      position: 101
      prefix: --pi_E
  - id: psi
    type:
      - 'null'
      - float
    doc: Value to fix BDEI removal rate psi. If not given, will be estimated.
    inputBinding:
      position: 101
      prefix: --psi
  - id: start
    type:
      - 'null'
      - type: array
        items: float
    doc: 'Starting values for parameter optimisation, should be 4 values in the following
      order: mu, lambda, psi, p. If not given, will be estimated.'
    inputBinding:
      position: 101
      prefix: --start
  - id: t
    type:
      - 'null'
      - float
    doc: "Total time between the tree roots and the end of the sampling period. If
      a positive value is given, the total time will be set to the maximum between
      this value and the maximal time between the start and the last sampled tip of
      all the trees. If a zero or negative value is given, the time will be tree-specific
      and estimated as the time between the root and the last sampled tip for each
      tree. In the latter case, one can additionally annotate each tree root with
      a feature 'T' (e.g. '(a:2,b:3):1[&&NHX:T=5];' is a tree with two tips, a and
      b, and the tree-specific time annotated to 5): then the tree-specific time will
      be set to the maximum between the annotated value and the time between the root
      and the last sampled tip of this tree."
    inputBinding:
      position: 101
      prefix: --T
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads for parallelization.
    inputBinding:
      position: 101
      prefix: --threads
  - id: u
    type:
      - 'null'
      - int
    doc: Number of unobserved trees. By default (-1) is estimated.
    inputBinding:
      position: 101
      prefix: --u
  - id: u_policy
    type:
      - 'null'
      - string
    doc: How to estimate the time for unobserved trees in case of tree-specific 
      observed tree times. By default, the mean of tree-specific observed times 
      is taken.
    inputBinding:
      position: 101
      prefix: --u_policy
  - id: upper_bounds
    type:
      - 'null'
      - type: array
        items: float
    doc: 'Upper bound on parameter values for parameter optimisation, should be in
      the following order: mu, lambda, psi, p. If not given, will be estimated.'
    inputBinding:
      position: 101
      prefix: --upper_bounds
outputs:
  - id: log
    type:
      - 'null'
      - File
    doc: Path to the output file where to write the estimates. If not given, the
      estimates will only be printed in the stdout
    outputBinding:
      glob: $(inputs.log)
  - id: time_log
    type:
      - 'null'
      - File
    doc: Path to the output file where to write the time. If not given, the time
      will only be printed in the stdout
    outputBinding:
      glob: $(inputs.time_log)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pybdei:0.13--py310hef477bb_1
