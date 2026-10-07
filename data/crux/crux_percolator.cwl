cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - crux
  - percolator
label: crux_percolator
doc: "Re-rank a collection of PSMs using the Percolator algorithm. Optionally, also
  produce protein rankings using the Fido algorithm.\n\nTool homepage: https://crux.ms"
inputs:
  - id: peptide_spectrum_matches
    type:
      type: array
      items: File
    doc: "One or more collections of target and decoy peptide-spectrum matches
      (PSMs). Input may be in one of four formats: PIN, SQT, pepXML, or Crux
      tab-delimited text. Note that if the input is provided as SQT, pepXML, or
      Crux tab-delimited text, then a PIN file will be generated in the output
      directory prior to execution. Crux determines the format of the input file
      by examining its filename extension."
    inputBinding:
      position: 1
  - id: c_neg
    type:
      - 'null'
      - float
    doc: "Penalty for mistake made on negative examples. If not specified, then this value is set by cross validation over {0.1, 1, 10}. Default = 0."
    inputBinding:
      position: 103
      prefix: --c-neg
  - id: c_pos
    type:
      - 'null'
      - float
    doc: "Penalty for mistakes made on positive examples. If this value is set to 0, then it is set via cross validation over the values {0.1, 1, 10}, selecting the value that yields the largest number of PSMs identified at the q-value threshold set via the --test-fdr parameter. Default = 0."
    inputBinding:
      position: 103
      prefix: --c-pos
  - id: decoy_prefix
    type:
      - 'null'
      - string
    doc: "Specifies the prefix of the protein names that indicate a decoy. Default = decoy_."
    inputBinding:
      position: 103
      prefix: --decoy-prefix
  - id: decoy_xml_output
    type:
      - 'null'
      - boolean
    doc: "Include decoys (PSMs, peptides, and/or proteins) in the XML output. Default = false."
    inputBinding:
      position: 103
      prefix: --decoy-xml-output
      valueFrom: '$(self ? "T" : "F")'
  - id: default_direction
    type:
      - 'null'
      - string
    doc: "In its initial round of training, Percolator uses one feature to induce a ranking of PSMs. By default, Percolator will select the feature that produces the largest set of target PSMs at a specified FDR threshold (cf. --train-fdr). This option allows the user to specify which feature is used for the initial ranking, using the name as a string. The name can be preceded by a hyphen (e.g. \"-XCorr\") to indicate that a lower value is better. Default = <empty>."
    inputBinding:
      position: 103
      prefix: --default-direction
  - id: feature_file_out
    type:
      - 'null'
      - boolean
    doc: "Output the computed features in tab-delimited Percolator input (.pin) format. The features will be normalized, using either unit norm or standard deviation normalization (depending upon the value of the unit-norm option). Default = false."
    inputBinding:
      position: 103
      prefix: --feature-file-out
      valueFrom: '$(self ? "T" : "F")'
  - id: fido_alpha
    type:
      - 'null'
      - float
    doc: "Specify the probability with which a present protein emits an associated peptide. Set by grid search (see --fido-gridsearch-depth parameter) if not specified. Default = 0."
    inputBinding:
      position: 103
      prefix: --fido-alpha
  - id: fido_beta
    type:
      - 'null'
      - float
    doc: "Specify the probability of the creation of a peptide from noise. Set by grid search (see --fido-gridsearch-depth parameter) if not specified. Default = 0."
    inputBinding:
      position: 103
      prefix: --fido-beta
  - id: fido_empirical_protein_q
    type:
      - 'null'
      - boolean
    doc: "Estimate empirical p-values and q-values for proteins using target-decoy analysis. Default = false."
    inputBinding:
      position: 103
      prefix: --fido-empirical-protein-q
      valueFrom: '$(self ? "T" : "F")'
  - id: fido_fast_gridsearch
    type:
      - 'null'
      - float
    doc: "Apply the specified threshold to PSM, peptide and protein probabilities to obtain a faster estimate of the alpha, beta and gamma parameters. Default = 0."
    inputBinding:
      position: 103
      prefix: --fido-fast-gridsearch
  - id: fido_gamma
    type:
      - 'null'
      - float
    doc: "Specify the prior probability that a protein is present in the sample. Set by grid search (see --fido-gridsearch-depth parameter) if not specified. Default = 0."
    inputBinding:
      position: 103
      prefix: --fido-gamma
  - id: fido_gridsearch_depth
    type:
      - 'null'
      - int
    doc: "Set depth of the grid search for alpha, beta and gamma estimation. Default = 0."
    inputBinding:
      position: 103
      prefix: --fido-gridsearch-depth
  - id: fido_gridsearch_mse_threshold
    type:
      - 'null'
      - float
    doc: "Q-value threshold that will be used in the computation of the MSE and ROC AUC score in the grid search. Default = 0.05."
    inputBinding:
      position: 103
      prefix: --fido-gridsearch-mse-threshold
  - id: fido_no_split_large_components
    type:
      - 'null'
      - boolean
    doc: "Do not approximate the posterior distribution by allowing large graph components to be split into subgraphs. The splitting is done by duplicating peptides with low probabilities. Splitting continues until the number of possible configurations of each subgraph is below 2^18 Default = false."
    inputBinding:
      position: 103
      prefix: --fido-no-split-large-components
      valueFrom: '$(self ? "T" : "F")'
  - id: fido_protein_truncation_threshold
    type:
      - 'null'
      - float
    doc: "To speed up inference, proteins for which none of the associated peptides has a probability exceeding the specified threshold will be assigned probability = 0. Default = 0.01."
    inputBinding:
      position: 103
      prefix: --fido-protein-truncation-threshold
  - id: fileroot
    type:
      - 'null'
      - string
    doc: "The fileroot string will be added as a prefix to all output file names. Default = <empty>."
    inputBinding:
      position: 103
      prefix: --fileroot
  - id: init_weights
    type:
      - 'null'
      - File
    doc: "Read initial weights from the given file (one per line). Default = <empty>."
    inputBinding:
      position: 103
      prefix: --init-weights
  - id: klammer
    type:
      - 'null'
      - boolean
    doc: "Use retention time features calculated as in \"Improving tandem mass spectrum identification using peptide retention time prediction across diverse chromatography conditions\" by Klammer AA, Yi X, MacCoss MJ and Noble WS. (Analytical Chemistry. 2007 Aug 15;79(16):6111-8.). Default = false."
    inputBinding:
      position: 103
      prefix: --klammer
      valueFrom: '$(self ? "T" : "F")'
  - id: max_charge_feature
    type:
      - 'null'
      - int
    doc: "Specifies the maximum charge state feature. When set to zero, use the maximum observed charge state. Default = 0."
    inputBinding:
      position: 103
      prefix: --max-charge-feature
  - id: maxiter
    type:
      - 'null'
      - int
    doc: "Maximum number of iterations for training. Default = 10."
    inputBinding:
      position: 103
      prefix: --maxiter
  - id: mzid_output
    type:
      - 'null'
      - boolean
    doc: "Output an mzIdentML results file to the output directory. Default = false."
    inputBinding:
      position: 103
      prefix: --mzid-output
      valueFrom: '$(self ? "T" : "F")'
  - id: only_psms
    type:
      - 'null'
      - boolean
    doc: "Do not remove redundant peptides; keep all PSMs and exclude peptide level probability. Default = false."
    inputBinding:
      position: 103
      prefix: --only-psms
      valueFrom: '$(self ? "T" : "F")'
  - id: output_dir
    type:
      - 'null'
      - string
    doc: "The name of the directory where output files will be created. Default = crux-output."
    inputBinding:
      position: 103
      prefix: --output-dir
  - id: output_weights
    type:
      - 'null'
      - boolean
    doc: "Output final weights to a file named \"percolator.weights.txt\". Default = false."
    inputBinding:
      position: 103
      prefix: --output-weights
      valueFrom: '$(self ? "T" : "F")'
  - id: override
    type:
      - 'null'
      - boolean
    doc: "By default, Percolator will examine the learned weights for each feature, and if the weight appears to be problematic, then percolator will discard the learned weights and instead employ a previously trained, static score vector. This switch allows this error checking to be overriden. Default = false."
    inputBinding:
      position: 103
      prefix: --override
      valueFrom: '$(self ? "T" : "F")'
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: "Replace existing files if true or fail when trying to overwrite a file if false. Default = false."
    inputBinding:
      position: 103
      prefix: --overwrite
      valueFrom: '$(self ? "T" : "F")'
  - id: parameter_file
    type:
      - 'null'
      - File
    doc: "A file containing parameters. Default = <empty>."
    inputBinding:
      position: 103
      prefix: --parameter-file
  - id: pepxml_output
    type:
      - 'null'
      - boolean
    doc: "Output a pepXML results file to the output directory. Default = false."
    inputBinding:
      position: 103
      prefix: --pepxml-output
      valueFrom: '$(self ? "T" : "F")'
  - id: percolator_seed
    type:
      - 'null'
      - string
    doc: "When given a unsigned integer value seeds the random number generator with that value. When given the string \"time\" seeds the random number generator with the system time. Default = 1."
    inputBinding:
      position: 103
      prefix: --percolator-seed
  - id: picked_protein
    type:
      - 'null'
      - File
    doc: "Use the picked protein-level FDR to infer protein probabilities, provide the fasta file as the argument to this flag. Default = <empty>."
    inputBinding:
      position: 103
      prefix: --picked-protein
  - id: pout_output
    type:
      - 'null'
      - boolean
    doc: "Output a Percolator pout.xml format results file to the output directory. Default = false."
    inputBinding:
      position: 103
      prefix: --pout-output
      valueFrom: '$(self ? "T" : "F")'
  - id: protein
    type:
      - 'null'
      - boolean
    doc: "Use the Fido algorithm to infer protein probabilities. Must be true to use any of the Fido options. Default = false."
    inputBinding:
      position: 103
      prefix: --protein
      valueFrom: '$(self ? "T" : "F")'
  - id: protein_enzyme
    type:
      - 'null'
      - string
    doc: "Type of enzyme Default = trypsin."
    inputBinding:
      position: 103
      prefix: --protein-enzyme
  - id: protein_report_duplicates
    type:
      - 'null'
      - boolean
    doc: "If multiple database proteins contain exactly the same set of peptides, then Percolator will randomly discard all but one of the proteins. If this option is set, then the IDs of these duplicated proteins will be reported as a comma-separated list. Not available for Fido. Default = false."
    inputBinding:
      position: 103
      prefix: --protein-report-duplicates
      valueFrom: '$(self ? "T" : "F")'
  - id: protein_report_fragments
    type:
      - 'null'
      - boolean
    doc: "By default, if the peptides associated with protein A are a proper subset of the peptides associated with protein B, then protein A is eliminated and all the peptides are considered as evidence for protein B. Note that this filtering is done based on the complete set of peptides in the database, not based on the identified peptides in the search results. Alternatively, if this option is set and if all of the identified peptides associated with protein B are also associated with protein A, then Percolator will report a comma-separated list of protein IDs, where the full-length protein B is first in the list and the fragment protein A is listed second. Not available for Fido. Default = false."
    inputBinding:
      position: 103
      prefix: --protein-report-fragments
      valueFrom: '$(self ? "T" : "F")'
  - id: quick_validation
    type:
      - 'null'
      - boolean
    doc: "Quicker execution by reduced internal cross-validation. Default = false."
    inputBinding:
      position: 103
      prefix: --quick-validation
      valueFrom: '$(self ? "T" : "F")'
  - id: search_input
    type:
      - 'null'
      - string
    doc: "Specify the type of target-decoy search. Using 'auto', percolator attempts to detect the search type automatically. Using 'separate' specifies two searches: one against target and one against decoy protein db. Using 'concatenated' specifies a single search on concatenated target-decoy protein db. Default = auto."
    inputBinding:
      position: 103
      prefix: --search-input
  - id: spectral_counting_fdr
    type:
      - 'null'
      - float
    doc: "Report the number of unique PSMs and total (including shared peptides) PSMs as two extra columns in the protein tab-delimited output. Default = 0."
    inputBinding:
      position: 103
      prefix: --spectral-counting-fdr
  - id: subset_max_train
    type:
      - 'null'
      - int
    doc: "Only train Percolator on a subset of PSMs, and use the resulting score vector to evaluate the other PSMs. Recommended when analyzing huge numbers (>1 million) of PSMs. When set to 0, all PSMs are used for training as normal. Default = 0."
    inputBinding:
      position: 103
      prefix: --subset-max-train
  - id: tdc
    type:
      - 'null'
      - boolean
    doc: "Use target-decoy competition to assign q-values and PEPs. When set to F, the mix-max method, which estimates the proportion pi0 of incorrect target PSMs, is used instead. Default = true."
    inputBinding:
      position: 103
      prefix: --tdc
      valueFrom: '$(self ? "T" : "F")'
  - id: test_each_iteration
    type:
      - 'null'
      - boolean
    doc: "Measure performance on test set each iteration. Default = false."
    inputBinding:
      position: 103
      prefix: --test-each-iteration
      valueFrom: '$(self ? "T" : "F")'
  - id: test_fdr
    type:
      - 'null'
      - float
    doc: "False discovery rate threshold used in selecting hyperparameters during internal cross-validation and for reporting the final results. Default = 0.01."
    inputBinding:
      position: 103
      prefix: --test-fdr
  - id: top_match
    type:
      - 'null'
      - int
    doc: "Specify the number of matches to report for each spectrum. Default = 5."
    inputBinding:
      position: 103
      prefix: --top-match
  - id: train_best_positive
    type:
      - 'null'
      - boolean
    doc: "Enforce that, for each spectrum, at most one PSM is included in the positive set during each training iteration. Note that if the user only provides one PSM per spectrum, then this option will have no effect. Default = false."
    inputBinding:
      position: 103
      prefix: --train-best-positive
      valueFrom: '$(self ? "T" : "F")'
  - id: train_fdr
    type:
      - 'null'
      - float
    doc: "False discovery rate threshold to define positive examples in training. Default = 0.01."
    inputBinding:
      position: 103
      prefix: --train-fdr
  - id: txt_output
    type:
      - 'null'
      - boolean
    doc: "Output a tab-delimited results file to the output directory. Default = true."
    inputBinding:
      position: 103
      prefix: --txt-output
      valueFrom: '$(self ? "T" : "F")'
  - id: unitnorm
    type:
      - 'null'
      - boolean
    doc: "Use unit normalization (i.e., linearly rescale each PSM's feature vector to have a Euclidean length of 1), instead of standard deviation normalization. Default = false."
    inputBinding:
      position: 103
      prefix: --unitnorm
      valueFrom: '$(self ? "T" : "F")'
  - id: verbosity
    type:
      - 'null'
      - int
    doc: "Specify the verbosity of the current processes. Each level prints the following messages, including all those at lower verbosity levels: 0-fatal errors, 10-non-fatal errors, 20-warnings, 30-information on the progress of execution, 40-more progress information, 50-debug info, 60-detailed debug info. Default = 30."
    inputBinding:
      position: 103
      prefix: --verbosity
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_dir_dir
    type:
      - 'null'
      - Directory
    doc: The name of the directory where output files will be created.
    outputBinding:
      glob: '$(inputs.output_dir ? inputs.output_dir : "crux-output")'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/crux:v3.2_cv3
stdout: crux_percolator.out
