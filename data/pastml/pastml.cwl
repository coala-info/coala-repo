cwlVersion: v1.2
class: CommandLineTool
baseCommand: pastml
label: pastml
doc: "Ancestral character reconstruction and visualisation for rooted phylogenetic
  trees.\n\nTool homepage: https://pastml.pasteur.fr"
inputs:
  - id: colours
    type:
      - 'null'
      - type: array
        items: File
    doc: 'optional way to specify the colours used for character state visualisation.
      Should be in the same order as the ancestral characters (see -c, --columns)
      for which the reconstruction is to be preformed. Could be given only for the
      first few characters. Each file should be tab-delimited, with two columns: the
      first one containing character states, and the second, named "colour", containing
      colours, in HEX format (e.g. #a6cee3).'
    inputBinding:
      position: 101
      prefix: --colours
  - id: columns
    type:
      - 'null'
      - type: array
        items: string
    doc: names of the annotation table columns that contain characters to be 
      analysed. If not specified, all columns are considered.
    inputBinding:
      position: 101
      prefix: --columns
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
    default: tab
    inputBinding:
      position: 101
      prefix: --data_sep
  - id: focus
    type:
      - 'null'
      - type: array
        items: string
    doc: optional way to put a focus on certain character state values, so that 
      the nodes in these states are displayed even if they do not pass the 
      trimming threshold (--tip_size_threshold). Should be in the form 
      character:state.
    inputBinding:
      position: 101
      prefix: --focus
  - id: forced_joint
    type:
      - 'null'
      - boolean
    doc: add JOINT state to the MPPA state selection even if it is not selected 
      by Brier score.
    inputBinding:
      position: 101
      prefix: --forced_joint
  - id: frequency_smoothing
    type:
      - 'null'
      - boolean
    doc: Apply a smoothing factor (optimised) to state frequencies (given as 
      input parameters, see --parameters) during likelihood calculation. If the 
      selected model (--model) does not allow for frequency optimisation, this 
      option will be ignored. If --reoptimise is also specified, the frequencies
      will only be smoothed but not reoptimised.
    inputBinding:
      position: 101
      prefix: --frequency_smoothing
  - id: id_index
    type:
      - 'null'
      - int
    doc: index of the annotation table column containing tree tip names, indices
      start from zero (by default is set to 0).
    default: 0
    inputBinding:
      position: 101
      prefix: --id_index
  - id: itol_id
    type:
      - 'null'
      - string
    doc: iTOL user batch upload ID that enables uploading to your iTOL account 
      (see https://itol.embl.de/help.cgi#batch).
    inputBinding:
      position: 101
      prefix: --itol_id
  - id: itol_project
    type:
      - 'null'
      - string
    doc: iTOL project the annotated tree should be associated with (must exist, 
      and --itol_id must be specified). By default set to 'Sample project'.
    default: Sample project
    inputBinding:
      position: 101
      prefix: --itol_project
  - id: itol_tree_name
    type:
      - 'null'
      - string
    doc: name for the tree uploaded to iTOL.
    inputBinding:
      position: 101
      prefix: --itol_tree_name
  - id: model
    type:
      - 'null'
      - type: array
        items: string
    doc: evolutionary model for ML methods (ignored by MP methods). When 
      multiple ancestral characters are specified (see -c, --columns), the same 
      model can be used for all of them (if only one model is specified), or 
      different models can be used (specified in the same order as -c, 
      --columns). If multiple models are given, but not for all the characters, 
      for the rest of them the default model (F81) is chosen.
    inputBinding:
      position: 101
      prefix: --model
  - id: name_column
    type:
      - 'null'
      - string
    doc: name of the character to be used for node names in the compressed map 
      visualisation (must be one of those specified via -c, --columns). If the 
      annotation table contains only one column it will be used by default.
    inputBinding:
      position: 101
      prefix: --name_column
  - id: offline
    type:
      - 'null'
      - boolean
    doc: By default (without --offline option) PastML assumes that there is an 
      internet connection available, which permits it to fetch CSS and JS 
      scripts needed for visualisation online.With --offline option turned on, 
      PastML will store all the needed CSS/JS scripts in the folder specified by
      --work_dir, so that internet connection is not needed (but you must not 
      move the output html files to any location other that the one specified by
      --html/--html_compressed).
    inputBinding:
      position: 101
      prefix: --offline
  - id: pajek_timing
    type:
      - 'null'
      - string
    doc: the type of the compressed visualisation to be saved in Pajek NET 
      Format (if --pajek is specified). Can be either VERTICAL (default, after 
      the nodes underwent vertical compression), HORIZONTAL (after the nodes 
      underwent vertical and horizontal compression) or TRIM (after the nodes 
      underwent vertical and horizontal compression and minor node trimming)
    default: VERTICAL
    inputBinding:
      position: 101
      prefix: --pajek_timing
  - id: parameters
    type:
      - 'null'
      - type: array
        items: File
    doc: 'optional way to fix some of the ML-method parameters by specifying files
      that contain them. Should be in the same order as the ancestral characters (see
      -c, --columns) for which the reconstruction is to be preformed. Could be given
      only for the first few characters. Each file should be tab-delimited, with two
      columns: the first one containing parameter names, and the second, named "value",
      containing parameter values. Parameters can include character state frequencies
      (parameter name should be the corresponding state, and parameter value - the
      float frequency value, between 0 and 1),tree branch scaling factor (parameter
      name scaling_factor),and tree branch smoothing factor (parameter name smoothing_factor),'
    inputBinding:
      position: 101
      prefix: --parameters
  - id: prediction_method
    type:
      - 'null'
      - type: array
        items: string
    doc: 'ancestral character reconstruction (ACR) method, can be one of the max likelihood
      (ML) methods: JOINT, MAP, MPPA, one of the max parsimony (MP) methods: DOWNPASS,
      ACCTRAN, DELTRAN; or COPY to keep the annotated character states as-is without
      inference. One can also specify one of the meta-methods ALL, ML, MP that would
      perform ACR with multiple methods (all of them for ALL, all the ML methods for
      ML, or all the MP methods for MP) and save/visualise the results as multiple
      characters suffixed with the corresponding method.When multiple ancestral characters
      are specified (see -c, --columns), the same method can be used for all of them
      (if only one method is specified), or different methods can be used (specified
      in the same order as -c, --columns). If multiple methods are given, but not
      for all the characters, for the rest of them the default method (MPPA) is chosen.'
    inputBinding:
      position: 101
      prefix: --prediction_method
  - id: rate_matrix
    type:
      - 'null'
      - type: array
        items: File
    doc: '(only for CUSTOM_RATES model) path to the file(s) containing the rate matrix(ces).
      Should be in the same order as the ancestral characters (see -c, --columns)
      for which the reconstruction is to be preformed. Could be given only for the
      first few characters. The rate matrix file should specify character states in
      its first line, preceded by # and separated by spaces. The following lines should
      contain a symmetric squared rate matrix with positive rates(and zeros on the
      diagonal), separated by spaces, in the same order at the character states specified
      in the first line.For example, for four states, A, C, G, T and the rates A<->C
      1, A<->G 4, A<->T 1, C<->G 1, C<->T 4, G<->T 1,the rate matrix file would look
      like: # A C G T 0 1 4 1 1 0 1 4 4 1 0 1 1 4 1 0'
    inputBinding:
      position: 101
      prefix: --rate_matrix
  - id: recursion_limit
    type:
      - 'null'
      - int
    doc: Set the recursion limit in python. If your tree is very large and 
      pastml produces an overflow error, you could try to set the recursion 
      limit to a large number (e.g., 10000). By default the standard recursion 
      limit is used and should be sufficient for trees of up to several thousand
      tips.
    inputBinding:
      position: 101
      prefix: --recursion_limit
  - id: reoptimise
    type:
      - 'null'
      - boolean
    doc: if the parameters are specified, they will be considered as an 
      optimisation starting point instead and optimised.
    inputBinding:
      position: 101
      prefix: --reoptimise
  - id: resolve_polytomies
    type:
      - 'null'
      - boolean
    doc: When specified, the polytomies with a state change (i.e. a parent node,
      P, in state A has more than 2 children, including m > 1 children, C_1, 
      ..., C_m, in state B) are resolved by grouping together same-state 
      (different from the parent state) nodes (i.e. a new internal node N in 
      state B is created and becomes the child of P and the parent of C_1, ..., 
      C_m).
    inputBinding:
      position: 101
      prefix: --resolve_polytomies
  - id: root_date
    type:
      - 'null'
      - type: array
        items: float
    doc: date(s) of the root(s) (for dated tree(s) only), if specified, used to 
      visualise a timeline based on dates (otherwise it is based on distances to
      root).
    inputBinding:
      position: 101
      prefix: --root_date
  - id: smoothing
    type:
      - 'null'
      - boolean
    doc: Apply a smoothing factor (optimised) to branch lengths during 
      likelihood calculation.
    inputBinding:
      position: 101
      prefix: --smoothing
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads PastML can use for parallesation. By default detected
      automatically based on the system. Note that PastML will at most use as 
      many threads as the number of characters (-c option) being analysed plus 
      one.
    inputBinding:
      position: 101
      prefix: --threads
  - id: timeline_type
    type:
      - 'null'
      - string
    doc: 'type of timeline visualisation: at each date/distance to root selected on
      the slider either (SAMPLED) - all the lineages sampled after it are hidden;
      or (NODES) - all the nodes with a more recent date/larger distance to root are
      hidden; or (LTT) - all the nodes whose branch started after this date/distance
      to root are hidden, and the external branches are cut to the specified date/distance
      to root if needed;'
    inputBinding:
      position: 101
      prefix: --timeline_type
  - id: tip_size_threshold
    type:
      - 'null'
      - float
    doc: recursively remove the tips of size less than threshold-th largest 
      tipfrom the compressed map (set to 1e10 to keep all tips). The larger it 
      is the less tips will be trimmed.
    inputBinding:
      position: 101
      prefix: --tip_size_threshold
  - id: tree
    type: File
    doc: input tree(s) in newick format (must be rooted).
    inputBinding:
      position: 101
      prefix: --tree
  - id: upload_to_itol
    type:
      - 'null'
      - boolean
    doc: create iTOL annotations for the reconstructed characters associated 
      with the named tree (i.e. the one found in --work_dir). If additionally 
      --itol_id and --itol_project are specified, the annotated tree will be 
      automatically uploaded to iTOL (https://itol.embl.de/).
    inputBinding:
      position: 101
      prefix: --upload_to_itol
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: print information on the progress of the analysis (to console)
    inputBinding:
      position: 101
      prefix: --verbose
  - id: work_dir
    type:
      - 'null'
      - Directory
    doc: path to the folder where pastml parameter, named tree and marginal 
      probability (for marginal ML methods (MAP, MPPA) only) files are to be 
      stored. Default is <path_to_input_file>/<input_file_name>_pastml. If the 
      folder does not exist, it will be created.
    inputBinding:
      position: 101
      prefix: --work_dir
outputs:
  - id: out_data
    type:
      - 'null'
      - File
    doc: path to the output annotation file with the reconstructed ancestral 
      character states.
    outputBinding:
      glob: $(inputs.out_data)
  - id: html_compressed
    type:
      - 'null'
      - File
    doc: path to the output compressed map visualisation file (html).
    outputBinding:
      glob: $(inputs.html_compressed)
  - id: pajek
    type:
      - 'null'
      - File
    doc: path to the output vertically compressed visualisation file (Pajek NET 
      Format). Prooduced only if --html_compressed is specified.
    outputBinding:
      glob: $(inputs.pajek)
  - id: html
    type:
      - 'null'
      - File
    doc: path to the output full tree visualisation file (html).
    outputBinding:
      glob: $(inputs.html)
  - id: html_mixed
    type:
      - 'null'
      - File
    doc: path to the output mostly compressed map visualisation file (html), 
      where the nodes in states specified with --focus are uncompressed.
    outputBinding:
      glob: $(inputs.html_mixed)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pastml:1.9.51--pyhdfd78af_0
