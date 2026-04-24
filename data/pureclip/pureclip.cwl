cwlVersion: v1.2
class: CommandLineTool
baseCommand: pureclip
label: pureclip
doc: "Protein-RNA interaction site detection using a non-homogeneous HMM.\n\nTool
  homepage: https://github.com/skrakau/PureCLIP"
inputs:
  - id: assign_crosslink_start
    type:
      - 'null'
      - boolean
    doc: Assign crosslink sites to read start positions.
    inputBinding:
      position: 101
      prefix: --ctr
  - id: auto_n_threshold
    type:
      - 'null'
      - boolean
    doc: Automatically choose n threshold (-ntp, -ntp2) to estimate parameters 
      linked to crosslink states.
    inputBinding:
      position: 101
      prefix: --antp
  - id: bandwidth
    type:
      - 'null'
      - int
    doc: Bandwidth for kernel density estimation used to access enrichment. In 
      range [1..500].
    inputBinding:
      position: 101
      prefix: --bdw
  - id: bandwidth_n
    type:
      - 'null'
      - int
    doc: Bandwidth for kernel density estimation used to estimate n for binomial
      distributions. In range [1..500].
    inputBinding:
      position: 101
      prefix: --bdwn
  - id: binding_characteristics
    type:
      - 'null'
      - int
    doc: Flag to set parameters according to binding characteristics of protein.
      In range [0..1].
    inputBinding:
      position: 101
      prefix: --bc
  - id: chromosomes_apply
    type:
      - 'null'
      - string
    doc: Contigs to apply HMM, e.g. 'chr1;chr2;chr3;'.
    inputBinding:
      position: 101
      prefix: --chr
  - id: control_bai
    type:
      - 'null'
      - File
    doc: File containing BAM index corresponding to mapped reads from control 
      experiment.
    inputBinding:
      position: 101
      prefix: --ibai
  - id: control_bam
    type:
      - 'null'
      - File
    doc: File containing mapped reads from control experiment, e.g. eCLIP input.
    inputBinding:
      position: 101
      prefix: --ibam
  - id: covariates_file
    type:
      - 'null'
      - File
    doc: 'Covariates file: position-wise values, e.g. smoothed reads start counts
      (KDEs) from input data.'
    inputBinding:
      position: 101
      prefix: --is
  - id: exclude_poly_a_analysis
    type:
      - 'null'
      - boolean
    doc: Exclude intervals containing poly-A stretches from analysis.
    inputBinding:
      position: 101
      prefix: --epaa
  - id: exclude_poly_a_learning
    type:
      - 'null'
      - boolean
    doc: Exclude intervals containing poly-A stretches from learning.
    inputBinding:
      position: 101
      prefix: --epal
  - id: exclude_poly_u_analysis
    type:
      - 'null'
      - boolean
    doc: Exclude intervals containing poly-U stretches from analysis.
    inputBinding:
      position: 101
      prefix: --epta
  - id: exclude_poly_u_learning
    type:
      - 'null'
      - boolean
    doc: Exclude intervals containing poly-U stretches from learning.
    inputBinding:
      position: 101
      prefix: --eptl
  - id: fimo_covariates
    type:
      - 'null'
      - File
    doc: Fimo input motif score covariates file.
    inputBinding:
      position: 101
      prefix: --fis
  - id: genome_file
    type: File
    doc: 'Genome reference file. Valid filetypes are: .fa, .fasta, .fa.gz, and .fasta.gz.'
    inputBinding:
      position: 101
      prefix: --genome
  - id: high_precision
    type:
      - 'null'
      - boolean
    doc: Use higher precision to store emission probabilities (long double).
    inputBinding:
      position: 101
      prefix: --ld
  - id: init_binomial_p_crosslink
    type:
      - 'null'
      - float
    doc: Initial value for binomial probability parameter of 'crosslink' state.
    inputBinding:
      position: 101
      prefix: --b2p
  - id: init_binomial_p_non_crosslink
    type:
      - 'null'
      - float
    doc: Initial value for binomial probability parameter of 'non-crosslink' 
      state.
    inputBinding:
      position: 101
      prefix: --b1p
  - id: input_bai
    type:
      type: array
      items: File
    doc: 'Target bam index files. Valid filetype is: .bai.'
    inputBinding:
      position: 101
      prefix: --bai
  - id: input_bam
    type:
      type: array
      items: File
    doc: 'Target bam files. Valid filetype is: .bam.'
    inputBinding:
      position: 101
      prefix: --in
  - id: intervals_learn
    type:
      - 'null'
      - string
    doc: Genomic chromosomes to learn HMM parameters, e.g. 'chr1;chr2;chr3'.
    inputBinding:
      position: 101
      prefix: --inter
  - id: lookup_table_min
    type:
      - 'null'
      - int
    doc: Minimum value in look-up table for log-sum-exp values.
    inputBinding:
      position: 101
      prefix: --tmv
  - id: lookup_table_size
    type:
      - 'null'
      - int
    doc: Size of look-up table for log-sum-exp values.
    inputBinding:
      position: 101
      prefix: --ts
  - id: max_iter_baum_welch
    type:
      - 'null'
      - int
    doc: Maximum number of iterations within Baum-Welch algorithm. In range 
      [0..500].
    inputBinding:
      position: 101
      prefix: --mibw
  - id: max_iter_brent
    type:
      - 'null'
      - int
    doc: Maximum number of iterations within BRENT algorithm. In range 
      [1..1000].
    inputBinding:
      position: 101
      prefix: --mibr
  - id: max_kn_ratio
    type:
      - 'null'
      - float
    doc: Max. k/N ratio used to learn truncation probabilities.
    inputBinding:
      position: 101
      prefix: --mkn
  - id: max_motif_id
    type:
      - 'null'
      - int
    doc: Max. motif ID to use.
    inputBinding:
      position: 101
      prefix: --nim
  - id: max_read_starts_learning
    type:
      - 'null'
      - int
    doc: Maximum number of read starts at one position used for learning. In 
      range [50..50000].
    inputBinding:
      position: 101
      prefix: --mtc
  - id: max_read_starts_stored
    type:
      - 'null'
      - int
    doc: Maximum number of read starts at one position stored. In range 
      [5000..65000].
    inputBinding:
      position: 101
      prefix: --mtc2
  - id: max_shape_k_enriched
    type:
      - 'null'
      - float
    doc: Maximum shape k of 'enriched' gamma distribution (g2.k).
    inputBinding:
      position: 101
      prefix: --g2kmax
  - id: max_shape_k_non_enriched
    type:
      - 'null'
      - float
    doc: Maximum shape k of 'non-enriched' gamma distribution (g1.k).
    inputBinding:
      position: 101
      prefix: --g1kmax
  - id: merge_distance
    type:
      - 'null'
      - int
    doc: Distance used to merge individual crosslink sites to binding regions.
    inputBinding:
      position: 101
      prefix: --dm
  - id: min_covariate_gamma_fit
    type:
      - 'null'
      - float
    doc: Fit gamma shape k only for positions with min. covariate value.
    inputBinding:
      position: 101
      prefix: --mrtf
  - id: min_kde_gamma_fit
    type:
      - 'null'
      - float
    doc: Minimum KDE value used for fitting left-truncated gamma distributions.
    inputBinding:
      position: 101
      prefix: --mkde
  - id: min_shape_k_enriched
    type:
      - 'null'
      - float
    doc: Minimum shape k of 'enriched' gamma distribution (g2.k).
    inputBinding:
      position: 101
      prefix: --g2kmin
  - id: min_shape_k_non_enriched
    type:
      - 'null'
      - float
    doc: Minimum shape k of 'non-enriched' gamma distribution (g1.k). In range 
      [1.5..inf].
    inputBinding:
      position: 101
      prefix: --g1kmin
  - id: min_transition_prob
    type:
      - 'null'
      - float
    doc: Min. transition probability from state '2' to '3'.
    inputBinding:
      position: 101
      prefix: --mtp
  - id: n_threshold_binomial
    type:
      - 'null'
      - int
    doc: Only sites with n >= ntp are used to learn binomial probability 
      parameters.
    inputBinding:
      position: 101
      prefix: --ntp
  - id: n_threshold_transition
    type:
      - 'null'
      - int
    doc: Only sites with n >= ntp2 are used to learn probability of transition 
      from state '2' to '2' or '3'.
    inputBinding:
      position: 101
      prefix: --ntp2
  - id: no_constrain_shape
    type:
      - 'null'
      - boolean
    doc: When incorporating input signal, do not constrain 'non-enriched' shape 
      parameter k <= 'enriched' gamma parameter k.
    inputBinding:
      position: 101
      prefix: --fk
  - id: output_all_sites
    type:
      - 'null'
      - boolean
    doc: Outputs all sites with at least one read start in extended output 
      format.
    inputBinding:
      position: 101
      prefix: --oa
  - id: poly_x_length_threshold
    type:
      - 'null'
      - int
    doc: Length threshold for internal poly-X stretches to get excluded.
    inputBinding:
      position: 101
      prefix: --pat
  - id: prior_enrichment_threshold
    type:
      - 'null'
      - int
    doc: Prior enrichment threshold for initial classification. In range 
      [2..50].
    inputBinding:
      position: 101
      prefix: --pet
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Set verbosity to a minimum.
    inputBinding:
      position: 101
      prefix: --quiet
  - id: read_selection
    type:
      - 'null'
      - int
    doc: 'Flag to define which read should be selected for the analysis: 1->R1, 2->R2.
      In range [1..2].'
    inputBinding:
      position: 101
      prefix: --ur
  - id: scoring_scheme
    type:
      - 'null'
      - int
    doc: Scoring scheme. 0 -> score_UC. In range [0..3].
    inputBinding:
      position: 101
      prefix: --st
  - id: threads_applying
    type:
      - 'null'
      - int
    doc: Number of threads used for applying learned parameters.
    inputBinding:
      position: 101
      prefix: --nta
  - id: threads_learning
    type:
      - 'null'
      - int
    doc: Number of threads used for learning.
    inputBinding:
      position: 101
      prefix: --nt
  - id: use_pseudo_emission
    type:
      - 'null'
      - boolean
    doc: Use (n dependent) pseudo emission probabilities for crosslink state.
    inputBinding:
      position: 101
      prefix: --upe
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output.
    inputBinding:
      position: 101
      prefix: --verbose
  - id: very_verbose
    type:
      - 'null'
      - boolean
    doc: Enable very verbose output.
    inputBinding:
      position: 101
      prefix: --very-verbose
outputs:
  - id: output_bed
    type: File
    doc: 'Output file to write crosslink sites. Valid filetype is: .bed.'
    outputBinding:
      glob: $(inputs.output_bed)
  - id: output_regions
    type:
      - 'null'
      - File
    doc: 'Output file to write binding regions. Valid filetype is: .bed.'
    outputBinding:
      glob: $(inputs.output_regions)
  - id: output_parameters
    type:
      - 'null'
      - File
    doc: Output file to write learned parameters.
    outputBinding:
      glob: $(inputs.output_parameters)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pureclip:1.3.1--r44h9ee0642_2
