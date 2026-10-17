cwlVersion: v1.2
class: CommandLineTool
baseCommand: bdei_u
label: pybdei_bdei_u
doc: "Calculator of the number of hidden trees in the forest under given BDEI model parameters.\n\nTool homepage: https://github.com/evolbioinfo/bdei"
inputs:
  - id: nwk
    type:
      - 'null'
      - File
    doc: "Observed tree(s) in newick format to calculate the total time T and the number of observed trees. If not given, f and T must be specified."
    inputBinding:
      position: 10
      prefix: --nwk
  - id: f
    type:
      - 'null'
      - int
    doc: "Number of observed trees. If not given, nwk must be specified."
    inputBinding:
      position: 10
      prefix: --f
  - id: mu
    type: double
    doc: "Value to fix BDEI becoming-infectious rate mu."
    inputBinding:
      position: 10
      prefix: --mu
  - id: la
    type: double
    doc: "Value to fix BDEI transmission rate lambda."
    inputBinding:
      position: 10
      prefix: --la
  - id: psi
    type: double
    doc: "Value to fix BDEI removal rate psi."
    inputBinding:
      position: 10
      prefix: --psi
  - id: p
    type: double
    doc: "Value to fix BDEI sampling probability."
    inputBinding:
      position: 10
      prefix: -p
  - id: pi_e
    type:
      - 'null'
      - double
    doc: "Frequency of E at time 0, should be between 0 and 1. If not given, will be estimated from the model parameters."
    inputBinding:
      position: 10
      prefix: --pi_E
  - id: t
    type:
      - 'null'
      - double
    doc: "Total time between the tree roots and the end of the sampling period. If a positive value is given, the total time will be set to the maximum between this value and the maximal time between the start and the last sampled tip of all the trees. If a zero or negative value is given, the time will be tree-specific and estimated as the time between the root and the last sampled tip for each tree."
    inputBinding:
      position: 10
      prefix: --T
  - id: u_policy
    type:
      - 'null'
      - type: enum
        symbols: [min, median, mean, max]
    doc: "How to estimate the time for unobserved trees in case of tree-specific observed tree times. By default, the mean of tree-specific observed times is taken."
    inputBinding:
      position: 10
      prefix: --u_policy
  - id: log_level
    type:
      - 'null'
      - int
    doc: "level of logging information (0 errors only, 1 errors+warnings, 2 errors+warnings+info, 3 errors+warnings+info+debug)."
    inputBinding:
      position: 10
      prefix: --log_level
outputs:
  - id: stdout_text
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pybdei:0.13--py310hef477bb_1
stdout: bdei_u.out
