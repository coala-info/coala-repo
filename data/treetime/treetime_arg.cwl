cwlVersion: v1.2
class: CommandLineTool
baseCommand: treetime_arg
label: treetime_arg
doc: "Calculates the root-to-tip regression and quantifies the 'clock-i-ness' of the
  tree. It will reroot the tree to maximize the clock-like signal and recalculate
  branch length unless run with --keep_root.\n\nTool homepage: https://github.com/neherlab/treetime"
inputs:
  - id: trees
    type:
      type: array
      items: File
    doc: Input tree file(s)
    inputBinding:
      position: 1
  - id: alignments
    type:
      type: array
      items: File
    doc: Alignment file(s)
    inputBinding:
      position: 2
  - id: mccs
    type: File
    doc: Maximum clade credibility file
    inputBinding:
      position: 3
  - id: aln
    type:
      - 'null'
      - File
    doc: alignment file (fasta)
    inputBinding:
      position: 104
      prefix: --aln
  - id: branch_length_mode
    type:
      - 'null'
      - string
    doc: If set to 'input', the provided branch length will be used without 
      modification. Note that branch lengths optimized by treetime are only 
      accurate at short evolutionary distances.
    inputBinding:
      position: 104
      prefix: --branch-length-mode
  - id: clock_filter
    type:
      - 'null'
      - float
    doc: ignore tips that don't follow a loose clock, 'clock-filter=number of 
      interquartile ranges from regression (method=`residual`)' or z-score of 
      local clock deviation (method=`local`). Default=4.0, set to 0 to switch 
      off.
    inputBinding:
      position: 104
      prefix: --clock-filter
  - id: clock_filter_method
    type:
      - 'null'
      - string
    doc: Use residuals from global clock (`residual`, default) or local clock 
      deviation (`clock`) to filter out tips that don't follow the clock
    inputBinding:
      position: 104
      prefix: --clock-filter-method
  - id: clock_rate
    type:
      - 'null'
      - float
    doc: if specified, the rate of the molecular clock won't be optimized.
    inputBinding:
      position: 104
      prefix: --clock-rate
  - id: clock_std_dev
    type:
      - 'null'
      - float
    doc: standard deviation of the provided clock rate estimate
    inputBinding:
      position: 104
      prefix: --clock-std-dev
  - id: coalescent
    type:
      - 'null'
      - string
    doc: coalescent time scale -- sensible values are on the order of the 
      average hamming distance of contemporaneous sequences. In addition, 'opt' 
      'skyline' are valid options and estimate a constant coalescent rate or a 
      piecewise linear coalescent rate history
    inputBinding:
      position: 104
      prefix: --coalescent
  - id: confidence
    type:
      - 'null'
      - boolean
    doc: estimate confidence intervals of divergence times using the marginal 
      posterior distribution, if `--time-marginal` is False (default) inferred 
      divergence times will still be calculated using the jointly most likely 
      tree configuration.
    inputBinding:
      position: 104
      prefix: --confidence
  - id: covariation
    type:
      - 'null'
      - boolean
    doc: Account for covariation when estimating rates or rerooting using 
      root-to-tip regression, default False.
    inputBinding:
      position: 104
      prefix: --covariation
  - id: date_column
    type:
      - 'null'
      - string
    doc: label of the column to be used as sampling date
    inputBinding:
      position: 104
      prefix: --date-column
  - id: dates
    type:
      - 'null'
      - File
    doc: csv file with dates for nodes with 'node_name, date' where date is 
      float (as in 2012.15) or in ISO-format (YYYY-MM-DD). Imprecisely known 
      dates can be specified as '2023-XX-XX' or [2013.2:2013.7]
    inputBinding:
      position: 104
      prefix: --dates
  - id: gen_per_year
    type:
      - 'null'
      - int
    doc: number of generations per year - used for estimating N_e in coalescent 
      models
    inputBinding:
      position: 104
      prefix: --gen-per-year
  - id: greedy_resolve
    type:
      - 'null'
      - boolean
    doc: Resolve polytomies greedily. Currently default, but will switched to 
      `stochastic-resolve` in future versions.
    inputBinding:
      position: 104
      prefix: --greedy-resolve
  - id: keep_overhangs
    type:
      - 'null'
      - boolean
    doc: do not fill terminal gaps
    inputBinding:
      position: 104
      prefix: --keep-overhangs
  - id: keep_polytomies
    type:
      - 'null'
      - boolean
    doc: Don't resolve polytomies using temporal information.
    inputBinding:
      position: 104
      prefix: --keep-polytomies
  - id: keep_root
    type:
      - 'null'
      - boolean
    doc: don't reroot the tree. Otherwise, reroot to minimize the the residual 
      of the regression of root-to-tip distance and sampling time
    inputBinding:
      position: 104
      prefix: --keep-root
  - id: max_iter
    type:
      - 'null'
      - int
    doc: maximal number of iterations the inference cycle is run. Note that for 
      polytomy resolution and coalescence models max_iter should be at least 2
    inputBinding:
      position: 104
      prefix: --max-iter
  - id: method_anc
    type:
      - 'null'
      - string
    doc: method used for reconstructing ancestral sequences, default is 
      'probabilistic'
    inputBinding:
      position: 104
      prefix: --method-anc
  - id: n_branches_posterior
    type:
      - 'null'
      - boolean
    doc: 'add posterior LH to coalescent model: use the posterior probability distributions
      of divergence times for estimating the number of branches when calculating the
      coalescent mergerrate or use inferred time before present (default).'
    inputBinding:
      position: 104
      prefix: --n-branches-posterior
  - id: n_skyline
    type:
      - 'null'
      - int
    doc: number of grid points in skyline coalescent model
    inputBinding:
      position: 104
      prefix: --n-skyline
  - id: name_column
    type:
      - 'null'
      - string
    doc: label of the column to be used as taxon name
    inputBinding:
      position: 104
      prefix: --name-column
  - id: no_tip_labels
    type:
      - 'null'
      - boolean
    doc: don't show tip labels (default for small trees with >=30 leaves)
    inputBinding:
      position: 104
      prefix: --no-tip-labels
  - id: reconstruct_tip_states
    type:
      - 'null'
      - boolean
    doc: overwrite ambiguous states on tips with the most likely inferred state
    inputBinding:
      position: 104
      prefix: --reconstruct-tip-states
  - id: relax
    type:
      - 'null'
      - type: array
        items: float
    doc: use an autocorrelated molecular clock. Strength of the gaussian priors 
      on branch specific rate deviation and the coupling of parent and offspring
      rates can be specified e.g. as --relax 1.0 0.5. Values around 1.0 
      correspond to weak priors, larger values constrain rate deviations more 
      strongly. Coupling 0 (--relax 1.0 0) corresponds to an un-correlated 
      clock.
    inputBinding:
      position: 104
      prefix: --relax
  - id: report_ambiguous
    type:
      - 'null'
      - boolean
    doc: include transitions involving ambiguous states
    inputBinding:
      position: 104
      prefix: --report-ambiguous
  - id: reroot
    type:
      - 'null'
      - type: array
        items: string
    doc: Reroot the tree using root-to-tip regression. Valid choices are 
      'min_dev', 'least-squares', and 'oldest'. 'least-squares' adjusts the root
      to minimize residuals of the root-to-tip vs sampling time regression, 
      'min_dev' minimizes variance of root-to-tip distances. 'least-squares' can
      be combined with --covariation to account for shared ancestry. 
      Alternatively, you can specify a node name or a list of node names to be 
      used as outgroup or use 'oldest' to reroot to the oldest node. By default,
      TreeTime will reroot using 'least-squares'. Use --keep-root to keep the 
      current root.
    inputBinding:
      position: 104
      prefix: --reroot
  - id: rng_seed
    type:
      - 'null'
      - int
    doc: random number generator seed for treetime
    inputBinding:
      position: 104
      prefix: --rng-seed
  - id: sequence_length
    type:
      - 'null'
      - int
    doc: length of the sequence, used to calculate expected variation in branch 
      length. Not required if alignment is provided.
    inputBinding:
      position: 104
      prefix: --sequence-length
  - id: stochastic_resolve
    type:
      - 'null'
      - boolean
    doc: Resolve polytomies using a random coalescent tree.
    inputBinding:
      position: 104
      prefix: --stochastic-resolve
  - id: time_marginal
    type:
      - 'null'
      - string
    doc: For 'false' or 'never', TreeTime uses the jointly most likely values 
      for the divergence times. For 'true' and 'always', it uses the marginal 
      inference mode at every round of optimization, for 'only-final' (or 
      'assign' for compatibility with previous versions) only uses the marginal 
      distribution in the final round.
    inputBinding:
      position: 104
      prefix: --time-marginal
  - id: tip_labels
    type:
      - 'null'
      - boolean
    doc: add tip labels (default for small trees with <30 leaves)
    inputBinding:
      position: 104
      prefix: --tip-labels
  - id: tip_slack
    type:
      - 'null'
      - float
    doc: excess variance associated with terminal nodes accounting for 
      overdispersion of the molecular clock
    inputBinding:
      position: 104
      prefix: --tip-slack
  - id: vcf_reference
    type:
      - 'null'
      - File
    doc: 'only for vcf input: fasta file of the sequence the VCF was mapped to.'
    inputBinding:
      position: 104
      prefix: --vcf-reference
  - id: verbose
    type:
      - 'null'
      - int
    doc: verbosity of output 0-6
    inputBinding:
      position: 104
      prefix: --verbose
  - id: zero_based
    type:
      - 'null'
      - boolean
    doc: zero based mutation indexing
    inputBinding:
      position: 104
      prefix: --zero-based
outputs:
  - id: plot_tree
    type:
      - 'null'
      - File
    doc: filename to save the plot to. Suffix will determine format (choices 
      pdf, png, svg, default=pdf)
    outputBinding:
      glob: $(inputs.plot_tree)
  - id: plot_rtt
    type:
      - 'null'
      - File
    doc: filename to save the plot to. Suffix will determine format (choices 
      pdf, png, svg, default=pdf)
    outputBinding:
      glob: $(inputs.plot_rtt)
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: directory to write the output to
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/treetime:0.11.4--pyhdfd78af_0
