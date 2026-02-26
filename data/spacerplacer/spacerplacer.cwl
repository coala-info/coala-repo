cwlVersion: v1.2
class: CommandLineTool
baseCommand: spacerplacer
label: spacerplacer
doc: "SpacerPlacer: An Ancestral Reconstruction Algorithm for CRISPR Arrays\n\nTool
  homepage: https://github.com/fbaumdicker/SpacerPlacer"
inputs:
  - id: input_path
    type: File
    doc: "Path to input file or folder containing input files.\nThe required input
      format is described in the readme."
    inputBinding:
      position: 1
  - id: output_path
    type: Directory
    doc: "Path to output folder. The output folder will be\ncreated, if it does not
      exist. The output folder will\ncontain files as described in the readme."
    inputBinding:
      position: 2
  - id: cluster_spacers
    type:
      - 'null'
      - boolean
    doc: "If given, the spacers of the input data are clustered\n(using levenshtein
      distance).The clustering process is\ndescribed in the paper."
    inputBinding:
      position: 103
      prefix: --cluster_spacers
  - id: cluster_spacers_max_distance
    type:
      - 'null'
      - int
    doc: "Determines the maximum Levenshtein distance for\nspacers to be clustered,
      i.e. identified with each\nother (same spacer id) within repeat groups."
    inputBinding:
      position: 103
      prefix: --cluster_spacers_max_distance
  - id: combine_non_unique_arrays
    type:
      - 'null'
      - boolean
    doc: "If given, arrays with the exactly the same spacer\ncontent are combined
      before the tree estimation and\nreconstruction. This might be helpful reduce
      clutter\n(especially in visualization).Arrays with the same\nspacer content
      can not be separated in the tree\nestimation anyway. The default is NOT to combine\n\
      arrays with the same spacer content. If arrays are\ncombined, the combined array
      names are saved in\ndetailed results csv under column \"combined array\nnames\"\
      ."
    inputBinding:
      position: 103
      prefix: --combine_non_unique_arrays
  - id: deletion_rate
    type:
      - 'null'
      - float
    doc: "Deletion rate of the reconstruction model. Generally\nshould be chosen to
      be large compared to the insertion\nrate. Otherwise may lead to high number
      of independent\nacquisitions and worse reconstructions. The ratio\nbetween insertion
      and deletion rate can be tuned in\ncase of reconstructions with excessive independent\n\
      acquisitions or excessive accumulations of insertions\nat the root. Default
      insertion and deletion rates are\nprovided and work well for the tested datasets."
    inputBinding:
      position: 103
      prefix: --deletion_rate
  - id: determine_orientation
    type:
      - 'null'
      - boolean
    doc: "If given, both a forward and a reverse reconstruction\nis made and the orientation
      of the arrays is\ndetermined by SpacerPlacer. Otherwise, the orientation\nis
      accepted as provided. Note, if the tree is\nestimated by SpacerPlacer, a separate
      tree ist\nestimated for the reversed array, i.e. the trees\nbetween forward
      and reverse orientation might differ."
    inputBinding:
      position: 103
      prefix: --determine_orientation
  - id: do_show
    type:
      - 'null'
      - boolean
    doc: "If given, the plots are shown directly. Might lead to\ncrash due to some
      issue with pyqt5."
    inputBinding:
      position: 103
      prefix: --do_show
  - id: dpi_rec
    type:
      - 'null'
      - int
    doc: DPI for the reconstruction plot pdf. Default is 90.
    default: 90
    inputBinding:
      position: 103
      prefix: --dpi_rec
  - id: extend_branches
    type:
      - 'null'
      - float
    doc: "Extends branches of the tree by the given value. This\nis useful, if the
      tree is not well resolved to allow\nplacement of events on small (or length=0)
      branches."
    inputBinding:
      position: 103
      prefix: --extend_branches
  - id: figsize_rec
    type:
      - 'null'
      - type: array
        items: string
    doc: "Provide the width and height of the reconstruction\nplot in the provided
      unit \"px\" (pixel), \"mm\" (millimeter) or \"in\" (inches). By default the
      size is\ndetermined by the drawing function."
    inputBinding:
      position: 103
      prefix: --figsize_rec
  - id: input_type
    type:
      - 'null'
      - string
    doc: "Determines the input type, i.e. either already\npreprocessed fasta style
      spacer arrays, a pickled file\nwith CRISPR group(s) (our own data structure),
      DNA\ndata (extracted from CRISPRCasdb) in a structure\ndescribed in the github
      repository or directly from\nresult.json files returned by CRISPRCasFinder."
    inputBinding:
      position: 103
      prefix: --input_type
  - id: insertion_rate
    type:
      - 'null'
      - float
    doc: "Insertion rate of the reconstruction model. Generally\nshould be chosen
      to be small compared to the deletion\nrate. Otherwise may lead to high number
      of independent\nacquisitions and worse reconstructions. The ratio\nbetween insertion
      and deletion rate can be tuned in\ncase of reconstructions with excessive independent\n\
      acquisitions or excessive accumulations of insertions\nat the root. Default
      insertion and deletion rates are\nprovided and work well for the tested datasets."
    inputBinding:
      position: 103
      prefix: --insertion_rate
  - id: lh_fct
    type:
      - 'null'
      - string
    doc: "Determines the likelihood function used for the Block\ndeletion model estimates
      and the likelihood ratio\ntest. \"simple\" allows bias corrections in rho and\n\
      alpha and was found to perform better in simulations.\n\"ode_based\" is the
      less performant, but, in theory,\nmore precise likelihood function."
    inputBinding:
      position: 103
      prefix: --lh_fct
  - id: min_evidence_level
    type:
      - 'null'
      - int
    doc: "Determines the minimum evidence level for the\nCRISPRCasFinder results to
      be included in the\nreconstruction. The evidence level is given in the\nCRISPRCasFinder
      output. The default (4) is the highest\npossible value."
    default: 4
    inputBinding:
      position: 103
      prefix: --min_evidence_level
  - id: no_alpha_bias_correction
    type:
      - 'null'
      - boolean
    doc: "If given, omits the alpha bias correction. Best\nperformance is achieved
      with the bias correction. Bias\ncorrection is only possible, if simple likelihood\n\
      function is used."
    inputBinding:
      position: 103
      prefix: --no_alpha_bias_correction
  - id: no_plot_order_graph
    type:
      - 'null'
      - boolean
    doc: "If given, the Partial Spacer Insertion Order is not\nplotted."
    inputBinding:
      position: 103
      prefix: --no_plot_order_graph
  - id: no_plot_reconstruction
    type:
      - 'null'
      - boolean
    doc: If given, the reconstruction is not plotted.
    inputBinding:
      position: 103
      prefix: --no_plot_reconstruction
  - id: no_rho_bias_correction
    type:
      - 'null'
      - boolean
    doc: "If given, omits the rho bias correction. Best\nperformance is achieved with
      the bias correction. Bias\ncorrection is only possible, if simple likelihood\n\
      function is used."
    inputBinding:
      position: 103
      prefix: --no_rho_bias_correction
  - id: orientation_decision_boundary
    type:
      - 'null'
      - float
    doc: "Determines the decision boundary for the orientation\ndecision. If the modulus
      of the difference between the\nlikelihoods of the two orientations is smaller
      than\nthe decision boundary, the orientation is set to \"not\ndetermined\" (ND).
      Otherwise, the orientation is set to\nthe orientation with the higher likelihood.
      The\ndecision boundary is given in logscale.The default\nvalue 5 was determined
      empirically and works well for\nthe tested datasets."
    default: 5
    inputBinding:
      position: 103
      prefix: --orientation_decision_boundary
  - id: rec_model
    type:
      - 'null'
      - string
    doc: "Determines the reconstruction model. Currently\nredundant, as only \"gtr\"\
      \ is implemented."
    inputBinding:
      position: 103
      prefix: --rec_model
  - id: save_reconstructed_events
    type:
      - 'null'
      - boolean
    doc: "If given, the tree and reconstructed events along the\ntree are saved in
      \"reconstructed_events\". On the basis\nof this data, the reconstruction is
      visualized and the\nevents can be analyzed in more detail. Currently only\n\
      works, if the the reconstruction is visualized."
    inputBinding:
      position: 103
      prefix: --save_reconstructed_events
  - id: seed
    type:
      - 'null'
      - int
    doc: "Seed for the random number generator only impact on\nMAFFT."
    inputBinding:
      position: 103
      prefix: --seed
  - id: show_spacer_name_row
    type:
      - 'null'
      - boolean
    doc: "If given, the spacer original names are shown in the\nreconstruction plot
      (above the alignment and the\nrespective spacer ids). This can be useful for\n\
      detailed analysis of the reconstruction. By default\nthe spacer names are shown."
    inputBinding:
      position: 103
      prefix: --show_spacer_name_row
  - id: significance_level
    type:
      - 'null'
      - float
    doc: "Determines the significance level for the likelihood\nratio test between
      the Independent Deletion Model and\nthe Block Deletion Model. The test statistic\n\
      (-2*ln(lh_idm/ln_bdm) = 2*ln(lh_bdm - ln_idm) is chi-\nsquared distributed with
      one single degree of freedom\nby Wilks' Theorem."
    inputBinding:
      position: 103
      prefix: --significance_level
  - id: tree_alpha
    type:
      - 'null'
      - float
    doc: "The user can provide their own deletion rate for the\ntree estimation based
      on the block deletion likelihood\nfunction. In the default case, well performing\n\
      parameters are chosen depending on the used likelihood\nfunction (\"simple\"\
      , \"ode_based\")."
    inputBinding:
      position: 103
      prefix: --tree_alpha
  - id: tree_construction_method
    type:
      - 'null'
      - string
    doc: "Determines the tree construction method used for the\ntree estimation. Currently
      UPGMA (upgma) and neighbor\njoining (nj) are implemented."
    inputBinding:
      position: 103
      prefix: --tree_construction_method
  - id: tree_deletion_rate
    type:
      - 'null'
      - float
    doc: "The user can provide their own deletion rate for the\ntree estimation based
      on the block deletion likelihood\nfunction. In the default case, well performing\n\
      parameters are chosen depending on the used likelihood\nfunction (\"simple\"\
      , \"ode_based\")."
    inputBinding:
      position: 103
      prefix: --tree_deletion_rate
  - id: tree_distance_function
    type:
      - 'null'
      - string
    doc: "Determines the distance function used for the tree\nestimation with UPGMA.
      Currently redundant, as only\n\"likelihood\" is implemented."
    inputBinding:
      position: 103
      prefix: --tree_distance_function
  - id: tree_insertion_rate
    type:
      - 'null'
      - float
    doc: "The user can provide their own insertion rate for the\ntree estimation based
      on the block deletion likelihood\nfunction. In the default case, well performing\n\
      parameters are chosen depending on the used likelihood\nfunction (\"simple\"\
      , \"ode_based\")."
    inputBinding:
      position: 103
      prefix: --tree_insertion_rate
  - id: tree_lh_fct
    type:
      - 'null'
      - string
    doc: "Determines the likelihood function used for the tree\nestimation with UPGMA.
      Details about the likelihood\nfunctions can be found in the paper. The default\n\
      \"simple\" has been found to perform better in\nsimulations."
    inputBinding:
      position: 103
      prefix: --tree_lh_fct
  - id: tree_path
    type:
      - 'null'
      - File
    doc: "Path to tree json file or folder with newick files. If\nnone is provided,
      trees are estimated by SpacerPlacer.\nThe trees can be given in a newick format
      or as a\ndictionary in a json file (such a json file is also\nreturned by SpacerPlacer)."
    inputBinding:
      position: 103
      prefix: --tree_path
  - id: verbosity
    type:
      - 'null'
      - int
    doc: "Verbosity level: 0: no output, 1: minimal output, 2:\nmaximal output (default
      1)."
    default: 1
    inputBinding:
      position: 103
      prefix: --verbosity
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spacerplacer:1.0.1--pyhdfd78af_0
stdout: spacerplacer.out
