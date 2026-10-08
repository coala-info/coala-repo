cwlVersion: v1.2
class: CommandLineTool
baseCommand: dfgTrain
label: evofold2_dfgTrain
doc: "dfgTrain trains discrete factor graph models by EM from data sets (and evaluates the probability of data sets under these models).\n\nTool homepage: https://github.com/jakob-skou-pedersen/phy"
inputs:
  - id: precision
    type:
      - 'null'
      - int
    doc: "Output precision of real numbers (default 5)"
    inputBinding:
      position: 1
      prefix: --precision
  - id: min_delta_log_lik
    type:
      - 'null'
      - float
    doc: "Stopping criterion of the EM training: stop when the difference in log likelihood is below this value (default 1e-4)"
    inputBinding:
      position: 2
      prefix: --minDeltaLogLik
  - id: max_iter
    type:
      - 'null'
      - int
    doc: "Max number of iterations of the EM training (default 100)"
    inputBinding:
      position: 3
      prefix: --maxIter
  - id: log_file_path
    type:
      - 'null'
      - string
    doc: "Log file for EM training (default logFile.txt)"
    inputBinding:
      position: 4
      prefix: --logFile
  - id: em_train
    type:
      - 'null'
      - boolean
    doc: "Perform EM training"
    inputBinding:
      position: 5
      prefix: --emTrain
  - id: dot_file_path
    type:
      - 'null'
      - string
    doc: "Output dfg in dot format to given fileName"
    inputBinding:
      position: 6
      prefix: --dotFile
  - id: out_spec_prefix
    type:
      - 'null'
      - string
    doc: "Prefix of the trained DFG specification files (default out_). Any included prefix directory must already exist."
    inputBinding:
      position: 7
      prefix: --outSpecPrefix
  - id: tmp_spec_prefix
    type:
      - 'null'
      - string
    doc: "Prefix of DFG specification files written during each iteration of training. Any included prefix directory must already exist."
    inputBinding:
      position: 8
      prefix: --tmpSpecPrefix
  - id: write_info
    type:
      - 'null'
      - boolean
    doc: "Print factor graph info. Useful for debugging factor graph specification."
    inputBinding:
      position: 9
      prefix: --writeInfo
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
  - id: stdout
    type: stdout
    doc: Standard output
  - id: log_file
    type:
      - 'null'
      - File
    doc: "Log file of the EM training"
    outputBinding:
      glob: $(inputs.log_file_path || "logFile.txt")
  - id: dot_file
    type:
      - 'null'
      - File
    doc: "Factor graph in dot format"
    outputBinding:
      glob: $(inputs.dot_file_path)
  - id: trained_spec_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Trained DFG specification files, named <outSpecPrefix><spec file name>
    outputBinding:
      glob: $((inputs.out_spec_prefix || "out_") + "*")
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
stdout: evofold2_dfgTrain.out
