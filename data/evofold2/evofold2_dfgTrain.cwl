cwlVersion: v1.2
class: CommandLineTool
baseCommand: dfgTrain
label: evofold2_dfgTrain
doc: "dfgTrain allows implementation of discrete factor graphs and evaluates the probability
  of data sets under these models.\n\nTool homepage: https://github.com/jakob-skou-pedersen/phy"
inputs:
  - id: input_var_data
    type: File
    doc: Input variable data in named data format
    inputBinding:
      position: 1
  - id: input_fac_data
    type:
      - 'null'
      - File
    doc: Input factor data in named data format
    inputBinding:
      position: 2
  - id: dfg_spec_prefix
    type:
      - 'null'
      - string
    doc: Prefix of DFG specification files.
    default: ./dfgSpec/
    inputBinding:
      position: 103
      prefix: --dfgSpecPrefix
  - id: em_train
    type:
      - 'null'
      - boolean
    doc: Perform EM training.
    inputBinding:
      position: 103
      prefix: --emTrain
  - id: fac_pot_file
    type:
      - 'null'
      - File
    doc: Specification of factor potentials.
    default: factorPotentials.txt
    inputBinding:
      position: 103
      prefix: --facPotFile
  - id: factor_graph_file
    type:
      - 'null'
      - File
    doc: Specification of the factor graph structure.
    default: factorGraph.txt
    inputBinding:
      position: 103
      prefix: --factorGraphFile
  - id: max_iter
    type:
      - 'null'
      - int
    doc: Max number of iterations of the EM training.
    default: 100
    inputBinding:
      position: 103
      prefix: --maxIter
  - id: min_delta_log_lik
    type:
      - 'null'
      - float
    doc: Defines stopping criteria for the EM training. The training will stop 
      when the difference in log likelihood is below minDeltaLogLik.
    default: 0.0001
    inputBinding:
      position: 103
      prefix: --minDeltaLogLik
  - id: out_spec_prefix
    type:
      - 'null'
      - string
    doc: Prefix of DFG specification files. Any included prefix directory must 
      already exist.
    default: out_
    inputBinding:
      position: 103
      prefix: --outSpecPrefix
  - id: precision
    type:
      - 'null'
      - int
    doc: Output precision of real numbers.
    default: 5
    inputBinding:
      position: 103
      prefix: --precision
  - id: state_map_file
    type:
      - 'null'
      - File
    doc: Specification of state maps.
    default: stateMaps.txt
    inputBinding:
      position: 103
      prefix: --stateMapFile
  - id: sub_var_file
    type:
      - 'null'
      - File
    doc: Input subscribed variables file in named data format. Must use same 
      identifiers in same order as varFile
    inputBinding:
      position: 103
      prefix: --subVarFile
  - id: tmp_spec_prefix
    type:
      - 'null'
      - string
    doc: Prefix of DFG specification files written during each iteration of 
      training. Allows state of EM to be saved.
    inputBinding:
      position: 103
      prefix: --tmpSpecPrefix
  - id: variables_file
    type:
      - 'null'
      - File
    doc: Specification of the state map used by each variable.
    default: variables.txt
    inputBinding:
      position: 103
      prefix: --variablesFile
  - id: write_info
    type:
      - 'null'
      - boolean
    doc: Print factor graph info. Useful for debugging factor graph 
      specification.
    inputBinding:
      position: 103
      prefix: --writeInfo
outputs:
  - id: log_file
    type:
      - 'null'
      - File
    doc: Log file for EM training.
    outputBinding:
      glob: $(inputs.log_file)
  - id: dot_file
    type:
      - 'null'
      - File
    doc: Output dfg in dot format to given fileName.
    outputBinding:
      glob: $(inputs.dot_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/evofold2:0.1--0
