cwlVersion: v1.2
class: CommandLineTool
baseCommand: dfgEval
label: evofold2_dfgEval
doc: "dfgEval allows implementation of discrete factor graphs and evaluates the probability
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
      - Directory
    doc: Prefix of DFG specification files..
    default: ./dfgSpec/
    inputBinding:
      position: 103
      prefix: --dfgSpecPrefix
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
  - id: minus_logarithm
    type:
      - 'null'
      - boolean
    doc: Output minus the natural logarithm of result values (program will 
      terminate on negative results...).
    inputBinding:
      position: 103
      prefix: --minusLogarithm
  - id: mps_vars
    type:
      - 'null'
      - string
    doc: Define the random variables for which the most probable state (mps) 
      should be output. Default is to output the mps for all random variables.
    inputBinding:
      position: 103
      prefix: --mpsVars
  - id: pp_sum_other
    type:
      - 'null'
      - boolean
    doc: For post probs, for each state output sum of post probs for all the 
      other states for that variable. This retains precision for post probs very
      close to one.
    inputBinding:
      position: 103
      prefix: --ppSumOther
  - id: pp_vars
    type:
      - 'null'
      - string
    doc: Define the random variables for which the posterior state probabilities
      (pp) should be calculated.
    inputBinding:
      position: 103
      prefix: --ppVars
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
  - id: variables_file
    type:
      - 'null'
      - File
    doc: Specification of the state map used by each variable.
    default: variables.txt
    inputBinding:
      position: 103
      prefix: --variablesFile
outputs:
  - id: pp_file
    type:
      - 'null'
      - File
    doc: Calculate posterior probabilities for each state of each random 
      variable and output to file.
    outputBinding:
      glob: $(inputs.pp_file)
  - id: nc_file
    type:
      - 'null'
      - File
    doc: Calculate normalization constant output to file.
    outputBinding:
      glob: $(inputs.nc_file)
  - id: mps_file
    type:
      - 'null'
      - File
    doc: Calculate most probable state for each random variable and output to 
      file.
    outputBinding:
      glob: $(inputs.mps_file)
  - id: exp_file
    type:
      - 'null'
      - File
    doc: Calculate expectancies and output to file
    outputBinding:
      glob: $(inputs.exp_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/evofold2:0.1--0
