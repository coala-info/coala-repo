cwlVersion: v1.2
class: CommandLineTool
baseCommand: XXmotif
label: xxmotif_XXmotif
doc: "XXmotif version 1.6\n\nTool homepage: https://github.com/soedinglab/xxmotif"
inputs:
  - id: output_dir
    type: Directory
    doc: output directory for all results
    inputBinding:
      position: 1
  - id: seq_file
    type: File
    doc: file name with sequences from positive set in FASTA format
    inputBinding:
      position: 2
  - id: add_columns
    type:
      - 'null'
      - type: array
        items: int
    doc: Add columns to the left and/or right of models. <INTEGER> >= 0
    inputBinding:
      position: 103
      prefix: --addColumns
  - id: alpha
    type:
      - 'null'
      - type: array
        items: float
    doc: Markov model pseudo-counts factor(s). Markov model order k fixes vector
      size to k+1. <FLOAT> >= 0
    inputBinding:
      position: 103
      prefix: --alpha
  - id: alpha_background
    type:
      - 'null'
      - float
    doc: Background model pseudo-counts factor. <FLOAT> >= 0
    inputBinding:
      position: 103
      prefix: --Alpha
  - id: background_intensity
    type:
      - 'null'
      - float
    doc: 'Background intensity value. Sequences having their intensity value below
      the background intensity value get assigned to weight zero. Option --rankWeighting
      must not be provided simultaneously (default: min. intensity value).'
    inputBinding:
      position: 103
      prefix: --backgroundIntensity
  - id: background_model_order
    type:
      - 'null'
      - int
    doc: order of background distribution
    inputBinding:
      position: 103
      prefix: --background-model-order
  - id: background_model_order_k
    type:
      - 'null'
      - int
    doc: Background model order. <INTEGER> >= 0.
    inputBinding:
      position: 103
      prefix: -K
  - id: background_quantile
    type:
      - 'null'
      - float
    doc: Quantile to estimate the background intensity value (or rank). 
      Sequences having their intensity value (rank) below (above) the background
      intensity value (rank) get assigned to weight zero. 0 <= <FLOAT> <= 1
    inputBinding:
      position: 103
      prefix: --backgroundQuantile
  - id: background_rank
    type:
      - 'null'
      - int
    doc: 'Background intensity rank. Sequences having their intensity rank above the
      background intensity rank get assigned to weight zero. Option --rankWeighting
      must be provided simultaneously (default: max. rank).'
    inputBinding:
      position: 103
      prefix: --backgroundRank
  - id: batch
    type:
      - 'null'
      - boolean
    doc: suppress progress bars (reduce output size for batch jobs)
    inputBinding:
      position: 103
      prefix: --batch
  - id: binding_site_background_intensity
    type:
      - 'null'
      - float
    doc: 'Background intensity value. Binding sites having their intensity value below
      the background intensity value get assigned to weight zero. Option --bindingSiteRankWeighting
      must not be provided simultaneously (default: min. intensity value).'
    inputBinding:
      position: 103
      prefix: --bindingSiteBackgroundIntensity
  - id: binding_site_background_quantile
    type:
      - 'null'
      - float
    doc: Quantile to estimate the background intensity value (or rank). Binding 
      sites having their intensity value (rank) below (below) the background 
      intensity value (rank) get assigned to weight zero. 0 <= <FLOAT> <= 1
    inputBinding:
      position: 103
      prefix: --bindingSiteBackgroundQuantile
  - id: binding_site_background_rank
    type:
      - 'null'
      - int
    doc: 'Background intensity rank. Binding sites having their intensity rank above
      the background intensity rank get assigned to weight zero. Option --bindingSiteRankWeighting
      must be provided simultaneously (default: max. rank).'
    inputBinding:
      position: 103
      prefix: --bindingSiteBackgroundRank
  - id: binding_site_file
    type:
      - 'null'
      - File
    doc: Binding sites file name to initialize a single Markov model. Sequence 
      lengths must not differ and be provided line-by-line.
    inputBinding:
      position: 103
      prefix: --bindingSiteFile
  - id: binding_site_ints_file
    type:
      - 'null'
      - File
    doc: Intensity or significance values for binding site sequences. The higher
      the values the higher the weights. Option --bindingSiteFile must be 
      provided simultaneously.
    inputBinding:
      position: 103
      prefix: --bindingSiteIntsFile
  - id: binding_site_length
    type:
      - 'null'
      - int
    doc: Specify the length of binding sites provided by --bindingSiteFile (not 
      mandatory).
    inputBinding:
      position: 103
      prefix: --bindingSiteLength
  - id: binding_site_rank_weighting
    type:
      - 'null'
      - boolean
    doc: 'Binding site rank-based weighting (default: intensity-based weighting).'
    inputBinding:
      position: 103
      prefix: --bindingSiteRankWeighting
  - id: downstream
    type:
      - 'null'
      - int
    doc: number of residues in positive set downstream of anchor point
    inputBinding:
      position: 103
      prefix: --downstream
  - id: em
    type:
      - 'null'
      - boolean
    doc: EM mode.
    inputBinding:
      position: 103
      prefix: --em
  - id: end_region
    type:
      - 'null'
      - int
    doc: expected end position for motif occurrences relative to anchor point
    inputBinding:
      position: 103
      prefix: --endRegion
  - id: epsilon
    type:
      - 'null'
      - float
    doc: EM convergence parameter. <FLOAT> > 0
    inputBinding:
      position: 103
      prefix: --epsilon
  - id: eta
    type:
      - 'null'
      - type: array
        items: float
    doc: Markov model pseudo-counts factor(s) defined by --alpha and -q. Markov 
      model order k fixes vector size to k+1. Specify either --eta or --alpha. 
      <FLOAT> >= 0
    inputBinding:
      position: 103
      prefix: --eta
  - id: evaluate_pwms
    type:
      - 'null'
      - boolean
    doc: Evaluate PWM model(s) used to initialize Markov model(s) on test 
      sequences.
    inputBinding:
      position: 103
      prefix: --evaluatePWMs
  - id: format
    type:
      - 'null'
      - string
    doc: defines what kind of format the input sequences have
    inputBinding:
      position: 103
      prefix: --format
  - id: gaps
    type:
      - 'null'
      - int
    doc: maximum number of gaps used for start seeds
    inputBinding:
      position: 103
      prefix: --gaps
  - id: init_ints
    type:
      - 'null'
      - boolean
    doc: Parameter to initialize models from XXmotif results by weighting 
      instances with corresponding sequence weigths. Option --sequenceIntsFile 
      must be provided simultaneously. Options --bindingSiteFile and 
      --markovModelFile must not be provided simultaneously.
    inputBinding:
      position: 103
      prefix: --initInts
  - id: interpolate
    type:
      - 'null'
      - boolean
    doc: Interpolate between higher- and lower-order probabilities.
    inputBinding:
      position: 103
      prefix: --interpolate
  - id: localization
    type:
      - 'null'
      - boolean
    doc: use localization information to calculate combined P-values
    inputBinding:
      position: 103
      prefix: --localization
  - id: log_probs
    type:
      - 'null'
      - boolean
    doc: Calculate log probabilities instead of log likelihood ratios.
    inputBinding:
      position: 103
      prefix: --logProbs
  - id: markov_model_file
    type:
      - 'null'
      - File
    doc: Markov model file name (without ending) to initialize a single Markov 
      model. Files <FILE>.conds and <FILE>.probs need to be available.
    inputBinding:
      position: 103
      prefix: --markovModelFile
  - id: markov_order
    type:
      - 'null'
      - int
    doc: Markov model order. <INTEGER> >= 0
    inputBinding:
      position: 103
      prefix: -k
  - id: max_em_iterations
    type:
      - 'null'
      - int
    doc: Max. number of EM iterations
    inputBinding:
      position: 103
      prefix: --maxEMIterations
  - id: max_match_positions
    type:
      - 'null'
      - int
    doc: max number of positions per motif
    inputBinding:
      position: 103
      prefix: --max-match-positions
  - id: max_models
    type:
      - 'null'
      - int
    doc: Max. number of XXmotif models used to initialize Markov models. 
      <INTEGER> > 0
    inputBinding:
      position: 103
      prefix: --maxModels
  - id: max_multiple_sequences
    type:
      - 'null'
      - float
    doc: maximum number of sequences used in an alignment
    inputBinding:
      position: 103
      prefix: --maxMultipleSequences
  - id: max_pos_set_size
    type:
      - 'null'
      - float
    doc: maximum number of sequences from the positive set used
    inputBinding:
      position: 103
      prefix: --maxPosSetSize
  - id: max_pvalue
    type:
      - 'null'
      - float
    doc: Max. p-value of XXmotif models used to initialize Markov models. Not 
      applied to min. number of models.
    inputBinding:
      position: 103
      prefix: --maxPvalue
  - id: merge_motif_threshold
    type:
      - 'null'
      - string
    doc: defines the similarity threshold for merging motifs
    inputBinding:
      position: 103
      prefix: --merge-motif-threshold
  - id: min_models
    type:
      - 'null'
      - int
    doc: Min. number of XXmotif models used to initialize Markov models. 
      Independent on options --maxPvalue and --minOccurrence. <INTEGER> > 0
    inputBinding:
      position: 103
      prefix: --minModels
  - id: min_occurrence
    type:
      - 'null'
      - float
    doc: Min. percentage of sequences containing a binding site instance. Not 
      applied to min. number of models.
    inputBinding:
      position: 103
      prefix: --minOccurrence
  - id: mops
    type:
      - 'null'
      - boolean
    doc: use multiple occurrence per sequence model
    inputBinding:
      position: 103
      prefix: --mops
  - id: msq
    type:
      - 'null'
      - boolean
    doc: Use model-specific specificity factors by considering the percentage of
      positive sequences containing a corresponding binding site instance.
    inputBinding:
      position: 103
      prefix: --msq
  - id: neg_set
    type:
      - 'null'
      - File
    doc: sequence set which has to be used as a reference set
    inputBinding:
      position: 103
      prefix: --negSet
  - id: no_expectation_maximization_phase
    type:
      - 'null'
      - boolean
    doc: Initialize Markov model but skip EM phase.
    inputBinding:
      position: 103
      prefix: --noExpectationMaximizationPhase
  - id: no_pwm_length_optimization
    type:
      - 'null'
      - boolean
    doc: do not optimize length during iterations (runtime advantages)
    inputBinding:
      position: 103
      prefix: --no-pwm-length-optimization
  - id: nr_models
    type:
      - 'null'
      - type: array
        items: int
    doc: Number of one or more XXmotif models in the ranking used to initialize 
      Markov models. The remaining parameters available to choose models from 
      XXmotif results are ignored.
    inputBinding:
      position: 103
      prefix: --nrModels
  - id: oops
    type:
      - 'null'
      - boolean
    doc: use one occurrence per sequence model
    inputBinding:
      position: 103
      prefix: --oops
  - id: profile_file
    type:
      - 'null'
      - File
    doc: profile file
    inputBinding:
      position: 103
      prefix: --profileFile
  - id: pseudo
    type:
      - 'null'
      - float
    doc: percentage of pseudocounts used
    inputBinding:
      position: 103
      prefix: --pseudo
  - id: rank_weighting
    type:
      - 'null'
      - boolean
    doc: 'Rank-based weighting (default: intensity-based weighting).'
    inputBinding:
      position: 103
      prefix: --rankWeighting
  - id: revcomp
    type:
      - 'null'
      - boolean
    doc: search in reverse complement of sequences as well
    inputBinding:
      position: 103
      prefix: --revcomp
  - id: save_expectation_maximization_likelihoods
    type:
      - 'null'
      - boolean
    doc: Save EM iteration's sequence likelihoods and positional odds to file.
    inputBinding:
      position: 103
      prefix: --saveExpectationMaximizationLikelihoods
  - id: save_expectation_maximization_models
    type:
      - 'null'
      - boolean
    doc: Save EM iteration's Markov models to file.
    inputBinding:
      position: 103
      prefix: --saveExpectationMaximizationModels
  - id: save_init_models
    type:
      - 'null'
      - boolean
    doc: Save Markov models after initialization to file.
    inputBinding:
      position: 103
      prefix: --saveInitModels
  - id: save_models
    type:
      - 'null'
      - boolean
    doc: Save Markov models after EM phase to file.
    inputBinding:
      position: 103
      prefix: --saveModels
  - id: sequence_ints_file
    type:
      - 'null'
      - File
    doc: Intensity or significance values for positive sequences. The higher the
      values the higher the weights.
    inputBinding:
      position: 103
      prefix: --sequenceIntsFile
  - id: specificity_factor
    type:
      - 'null'
      - float
    doc: Specificity factor approximates the percentage of sequences 
      contributing to the Markov model. 0 < <FLOAT> < 1
    inputBinding:
      position: 103
      prefix: -q
  - id: start_motif
    type:
      - 'null'
      - string
    doc: Start motif (IUPAC characters)
    inputBinding:
      position: 103
      prefix: --startMotif
  - id: start_region
    type:
      - 'null'
      - int
    doc: expected start position for motif occurrences relative to anchor point
    inputBinding:
      position: 103
      prefix: --startRegion
  - id: test_neg_set
    type:
      - 'null'
      - boolean
    doc: Evaluate model(s) on background sequences.
    inputBinding:
      position: 103
      prefix: --testNegSet
  - id: test_pos_set
    type:
      - 'null'
      - boolean
    doc: Evaluate model(s) on training sequences.
    inputBinding:
      position: 103
      prefix: --testPosSet
  - id: test_set
    type:
      - 'null'
      - type: array
        items: File
    doc: Evaluate model(s) on sequences in FASTA format. Specify one or more 
      files. Sequence lengths may differ.
    inputBinding:
      position: 103
      prefix: --testSet
  - id: tracked_motif
    type:
      - 'null'
      - string
    doc: inspect extensions and refinement of a given seed
    inputBinding:
      position: 103
      prefix: --trackedMotif
  - id: type
    type:
      - 'null'
      - string
    doc: defines what kind of start seeds are used
    inputBinding:
      position: 103
      prefix: --type
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose printouts.
    inputBinding:
      position: 103
      prefix: --verbose
  - id: zoops
    type:
      - 'null'
      - boolean
    doc: use zero-or-one occurrence per sequence model
    inputBinding:
      position: 103
      prefix: --zoops
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xxmotif:1.6--0
stdout: xxmotif_XXmotif.out
