cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastme
label: fastme
doc: "A comprehensive, accurate and fast distance-based phylogeny inference program.\n\
  \nTool homepage: http://www.atgc-montpellier.fr/fastme/binaries.php"
inputs:
  - id: append
    type:
      - 'null'
      - boolean
    doc: Use this option to append results to existing output files (if any). By
      default output files will be overwritten.
    inputBinding:
      position: 101
      prefix: --append
  - id: bootstrap_replicates
    type:
      - 'null'
      - int
    doc: Use this option to indicate the number of replicates FastME will do for
      bootstrapping. Default value is 0. Only helpful when the input data file 
      contains sequences alignment(s).
    inputBinding:
      position: 101
      prefix: --bootstrap
  - id: branch_length
    type:
      - 'null'
      - string
    doc: 'Use this option to indicate the branch length to assign to the tree. You
      may choose the branch length from: (B)alLS (default), (O)LS or (n)one. (n)one
      is only available with BIONJ, NJ or UNJ. Only helpful when not improving the
      tree topology (no NNI nor SPR).'
    inputBinding:
      position: 101
      prefix: --branch_length
  - id: compute_distance_matrix_only
    type:
      - 'null'
      - boolean
    doc: Use this option if you want FastME only to compute distance matrix. 
      Only helpful when the input data file contains sequences alignment(s).
    inputBinding:
      position: 101
      prefix: -c
  - id: correct_distances
    type:
      - 'null'
      - boolean
    doc: Use this option to let FastME corrects the distances in case of 
      triangular inequality violation.
    inputBinding:
      position: 101
      prefix: -q
  - id: datasets
    type:
      - 'null'
      - int
    doc: Use this option to indicate the number of datasets in your input data 
      file. Default value is 1.
    inputBinding:
      position: 101
      prefix: --datasets
  - id: dna_model
    type:
      - 'null'
      - string
    doc: 'Use this option if your input data file contains DNA sequences alignment(s).
      You may also indicate the evolutionary [model] which can be choosen from: (p)-distance,
      R(Y) symmetric, (R)Y, (J)C69, (K)2P, F8(1), F8(4) (default), (T)N93, (L)ogDet.'
    inputBinding:
      position: 101
      prefix: --dna
  - id: equilibrium
    type:
      - 'null'
      - boolean
    doc: The equilibrium frequencies for DNA are always estimated by counting 
      the occurence of the nucleotides in the input alignment. For amino-acid 
      sequences, the equilibrium frequencies are estimated using the frequencies
      defined by the substitution model. Use this option if you whish to 
      estimate the amino-acid frequencies by counting their occurence in the 
      input alignment.
    inputBinding:
      position: 101
      prefix: --equilibrium
  - id: gamma
    type:
      - 'null'
      - float
    doc: Use this option if you wish to have gamma distributed rates across 
      sites. By default, FastME runs with no gamma variation. If running FastME 
      with gamma distributed rates across sites, the [alpha] default value is 
      1.0. Only helpful when the input data file contains sequences 
      alignment(s).
    inputBinding:
      position: 101
      prefix: --gamma
  - id: input_data_file
    type:
      - 'null'
      - File
    doc: The input data file contains sequence alignment(s) or a distance 
      matrix(ces).
    inputBinding:
      position: 101
      prefix: --input_data
  - id: input_user_tree_file
    type:
      - 'null'
      - File
    doc: FastME may use an existing topology available in the input user tree 
      file which corresponds to the input dataset.
    inputBinding:
      position: 101
      prefix: --user_tree
  - id: method
    type:
      - 'null'
      - string
    doc: 'FastME computes a tree using a distance algorithm. You may choose this method
      from: TaxAdd_(B)alME, TaxAdd_(O)LSME, B(I)ONJ (default), (N)J or (U)NJ.'
    inputBinding:
      position: 101
      prefix: --method
  - id: nni
    type:
      - 'null'
      - string
    doc: 'Use this option to do [NNI] tree topology improvement. You may choose the
      [NNI] type from: NNI_(B)alME (default) or NNI_(O)LS.'
    inputBinding:
      position: 101
      prefix: --nni
  - id: num_digits
    type:
      - 'null'
      - int
    doc: Use this option to set the number of digits after the dot to use on 
      output. Default number of digits is 8.
    inputBinding:
      position: 101
      prefix: -f
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Use this option to set the number of threads to use. Default number of 
      threads is 20.
    inputBinding:
      position: 101
      prefix: --nb_threads
  - id: protein_model
    type:
      - 'null'
      - string
    doc: 'Use this option if your input data file contains protein sequences alignment(s).
      You may also indicate the evolutionary [model] which can be choosen from: (p)-distance,
      (F)81 like, (L)G (default), (W)AG, (J)TT, Day(h)off, (D)CMut, (C)pRev, (M)tREV,
      (R)tREV, HIV(b), H(I)Vw or FL(U).'
    inputBinding:
      position: 101
      prefix: --protein
  - id: remove_gap
    type:
      - 'null'
      - boolean
    doc: Use this option to completely remove any site which has a gap in any 
      sequence. By default, FastME is doing pairwise deletion of gaps.
    inputBinding:
      position: 101
      prefix: --remove_gap
  - id: seed
    type:
      - 'null'
      - int
    doc: Use this option to initialize randomization with seed value. Only 
      helpful when bootstrapping.
    inputBinding:
      position: 101
      prefix: --seed
  - id: spr
    type:
      - 'null'
      - boolean
    doc: Use this option to do SPR tree topology improvement.
    inputBinding:
      position: 101
      prefix: --spr
  - id: verbose
    type:
      - 'null'
      - int
    doc: Sets the verbose level to value [0-3]. Default value is 0.
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_tree_file
    type:
      - 'null'
      - File
    doc: FastME will write the infered tree into the output tree file.
    outputBinding:
      glob: $(inputs.output_tree_file)
  - id: output_matrix_file
    type:
      - 'null'
      - File
    doc: Use this option if you want FastME to write the distances matrix 
      computed from the input alignment in the output matrix file.
    outputBinding:
      glob: $(inputs.output_matrix_file)
  - id: output_information_file
    type:
      - 'null'
      - File
    doc: Use this option if you want FastME to write information about its 
      execution in the output information file.
    outputBinding:
      glob: $(inputs.output_information_file)
  - id: output_bootstrap_trees_file
    type:
      - 'null'
      - File
    doc: Use this option if you want FastME to write bootstrap trees in the 
      bootstrap trees file.
    outputBinding:
      glob: $(inputs.output_bootstrap_trees_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastme:2.1.6.3--h7b50bb2_1
