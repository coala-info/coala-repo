cwlVersion: v1.2
class: CommandLineTool
baseCommand: transition_counter
label: pastml_transition_counter
doc: "Transition counting for PastML ACR\n\nTool homepage: https://github.com/evolbioinfo/pastml"
inputs:
  - id: tree
    type: File
    doc: input tree(s) in newick format (must be rooted).
    inputBinding:
      position: 101
      prefix: --tree
  - id: data
    type:
      - 'null'
      - File
    doc: annotation file in tab/csv format with the first row containing the 
      column names. If not given, the annotations should be contained in the 
      tree file itself.
    inputBinding:
      position: 101
      prefix: --data
  - id: data_sep
    type:
      - 'null'
      - string
    doc: column separator for the annotation table. By default is set to tab, 
      i.e. for a tab-delimited file. Set it to ',' if your file is csv.
    inputBinding:
      position: 101
      prefix: --data_sep
  - id: id_index
    type:
      - 'null'
      - int
    doc: index of the annotation table column containing tree tip names, 
      indices start from zero (by default is set to 0).
    inputBinding:
      position: 101
      prefix: --id_index
  - id: column
    type: string
    doc: the name of the annotation table column that contain the character to 
      be analysed.
    inputBinding:
      position: 101
      prefix: --column
  - id: model
    type:
      - 'null'
      - string
    doc: evolutionary model for ML methods (JC, F81, EFT, HKY, JTT or 
      CUSTOM_RATES). The default model is F81.
    inputBinding:
      position: 101
      prefix: --model
  - id: parameters
    type: File
    doc: the ML-method parameters, specified as a path to a tab-delimited file 
      with two columns, the first one containing parameter names, and the 
      second, named "value", containing parameter values. Parameters can include
      character state frequencies (parameter name should be the corresponding 
      state, and parameter value - the float frequency value, between 0 and 1),
      tree branch scaling factor (parameter name scaling_factor), and tree 
      branch smoothing factor (parameter name smoothing_factor).
    inputBinding:
      position: 101
      prefix: --parameters
  - id: rate_matrix
    type:
      - 'null'
      - File
    doc: (only for CUSTOM_RATES model) path to the file containing the rate 
      matrix. The rate matrix file should specify character states in its first
      line, preceded by the hash sign and separated by spaces. The following lines should 
      contain a symmetric squared rate matrix with positive rates (and zeros on
      the diagonal), separated by spaces, in the same order at the character 
      states specified in the first line.
    inputBinding:
      position: 101
      prefix: --rate_matrix
  - id: n_repetitions
    type:
      - 'null'
      - int
    doc: (default 1000) Number of times the ancestral scenario is drawn from the
      marginal probabilities. The transition counts are averaged over all these 
      scenarios.
    inputBinding:
      position: 101
      prefix: --n_repetitions
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: print information on the progress of the analysis (to console)
    inputBinding:
      position: 101
      prefix: --verbose
  - id: offline
    type:
      - 'null'
      - boolean
    doc: By default (without --offline option) PastML assumes that there is an 
      internet connection available, which permits it to fetch CSS and JS 
      scripts needed for visualisation online. With --offline option turned on, 
      PastML will store all the needed CSS/JS scripts in the folder specified by
      --work_dir, so that internet connection is not needed (but you must not 
      move the output html files to any location other that the one specified by
      --html).
    inputBinding:
      position: 101
      prefix: --offline
  - id: work_dir_path
    type: string
    doc: path to the folder where pastml will store all the needed CSS/JS 
      scripts for the --offline mode. If the folder does not exist, it will be 
      created.
    inputBinding:
      position: 101
      prefix: --work_dir
  - id: colours
    type:
      - 'null'
      - File
    doc: optional way to specify the colours used for character state 
      visualisation. A tab-delimited file, with two columns, the first one 
      containing character states, and the second, named "colour", containing 
      colours, in HEX format (for example a6cee3 after a hash sign).
    inputBinding:
      position: 101
      prefix: --colours
  - id: threshold
    type:
      - 'null'
      - float
    doc: Do not visualise the interactions below this threshold value.
    inputBinding:
      position: 101
      prefix: --threshold
  - id: html_path
    type:
      - 'null'
      - string
    doc: path to the output transition visualisation file (html).
    inputBinding:
      position: 102
      prefix: --html
  - id: out_transitions_path
    type: string
    doc: path to the output transition count file.
    inputBinding:
      position: 103
      prefix: --out_transitions
outputs:
  - id: out_transitions
    type: File
    doc: the output transition count file.
    outputBinding:
      glob: $(inputs.out_transitions_path)
  - id: html
    type:
      - 'null'
      - File
    doc: the output transition visualisation file (html).
    outputBinding:
      glob: $(inputs.html_path)
  - id: work_dir
    type: Directory
    doc: folder with the CSS/JS scripts and other files written by pastml.
    outputBinding:
      glob: $(inputs.work_dir_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pastml:1.9.51--pyhdfd78af_0
