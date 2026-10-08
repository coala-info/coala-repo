cwlVersion: v1.2
class: CommandLineTool
baseCommand: dfgEval
label: evofold2_dfgEval
doc: "dfgEval allows implementation of discrete factor graphs and evaluates the probability of data sets under these models.\n\nTool homepage: https://github.com/jakob-skou-pedersen/phy"
inputs:
  - id: pp_file_path
    type:
      - 'null'
      - string
    doc: "Calculate posterior probabilities for each state of each random variable and output to file."
    inputBinding:
      position: 1
      prefix: --ppFile
  - id: nc_file_path
    type:
      - 'null'
      - string
    doc: "Calculate normalization constant and output to file."
    inputBinding:
      position: 2
      prefix: --ncFile
  - id: mps_file_path
    type:
      - 'null'
      - string
    doc: "Calculate most probable state for each random variable and output to file."
    inputBinding:
      position: 3
      prefix: --mpsFile
  - id: exp_file_path
    type:
      - 'null'
      - string
    doc: "Calculate expectancies and output to file"
    inputBinding:
      position: 4
      prefix: --expFile
  - id: precision
    type:
      - 'null'
      - int
    doc: "Output precision of real numbers (default 5)"
    inputBinding:
      position: 5
      prefix: --precision
  - id: pp_sum_other
    type:
      - 'null'
      - boolean
    doc: "For post probs, for each state output sum of post probs for all the other states for that variable. This retains precision for post probs very close to one."
    inputBinding:
      position: 6
      prefix: --ppSumOther
  - id: minus_logarithm
    type:
      - 'null'
      - boolean
    doc: "Output minus the natural logarithm of result values (program will terminate on negative results...)."
    inputBinding:
      position: 7
      prefix: --minusLogarithm
  - id: mps_vars
    type:
      - 'null'
      - string
    doc: "Random variables for which the most probable state should be output, whitespace separated, e.g. \"X Y\" (default all)"
    inputBinding:
      position: 8
      prefix: --mpsVars
  - id: pp_vars
    type:
      - 'null'
      - string
    doc: "Random variables for which posterior state probabilities are calculated, semicolon separated, e.g. \"X=a b c; Y=a b\" (default all)"
    inputBinding:
      position: 9
      prefix: --ppVars
  - id: spec_dir
    type:
      - 'null'
      - Directory
    doc: "Directory with the DFG specification files; staged as ./dfgSpec/ (the default --dfgSpecPrefix) so the file names below resolve"
  - id: dfg_spec_prefix
    type:
      - 'null'
      - string
    doc: "Prefix of DFG specification files (default ./dfgSpec/)"
    inputBinding:
      position: 10
      prefix: --dfgSpecPrefix
  - id: factor_graph_file
    type:
      - 'null'
      - string
    doc: "Specification of the factor graph structure, name inside the spec prefix (default factorGraph.txt)"
    inputBinding:
      position: 11
      prefix: --factorGraphFile
  - id: variables_file
    type:
      - 'null'
      - string
    doc: "Specification of the state map used by each variable, name inside the spec prefix (default variables.txt)"
    inputBinding:
      position: 12
      prefix: --variablesFile
  - id: state_map_file
    type:
      - 'null'
      - string
    doc: "Specification of state maps, name inside the spec prefix (default stateMaps.txt)"
    inputBinding:
      position: 13
      prefix: --stateMapFile
  - id: fac_pot_file
    type:
      - 'null'
      - string
    doc: "Specification of factor potentials, name inside the spec prefix (default factorPotentials.txt)"
    inputBinding:
      position: 14
      prefix: --facPotFile
  - id: sub_var_file
    type:
      - 'null'
      - File
    doc: "Input subscribed variables file in named data format. Must use same identifiers in same order as varFile"
    inputBinding:
      position: 15
      prefix: --subVarFile
  - id: input_var_data
    type: File
    doc: "Input variable data in named data format"
    inputBinding:
      position: 100
  - id: input_fac_data
    type:
      - 'null'
      - File
    doc: "Input factor data in named data format"
    inputBinding:
      position: 101
outputs:
  - id: pp_file
    type:
      - 'null'
      - File
    doc: "Posterior probabilities"
    outputBinding:
      glob: $(inputs.pp_file_path)
  - id: nc_file
    type:
      - 'null'
      - File
    doc: "Normalization constants"
    outputBinding:
      glob: $(inputs.nc_file_path)
  - id: mps_file
    type:
      - 'null'
      - File
    doc: "Most probable states"
    outputBinding:
      glob: $(inputs.mps_file_path)
  - id: exp_file
    type:
      - 'null'
      - File
    doc: "Expectancies"
    outputBinding:
      glob: $(inputs.exp_file_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |
      ${
        return inputs.spec_dir ? [{entry: inputs.spec_dir, entryname: "dfgSpec"}] : [];
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/evofold2:0.1--0
