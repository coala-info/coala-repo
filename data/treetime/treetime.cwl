cwlVersion: v1.2
class: CommandLineTool
baseCommand: treetime
label: treetime
doc: "Maximum likelihood phylodynamics: infers a time-scaled phylogeny (time tree) from a tree, an alignment or sequence length, and sampling dates.\n\nTool homepage: https://github.com/neherlab/treetime"
inputs:
  - id: tree
    type:
      - 'null'
      - File
    doc: "Tree file in newick, nexus or phylip format; branch lengths in substitutions per site. If absent, treetime builds a tree with fasttree, iqtree or raxml."
    inputBinding:
      position: 101
      prefix: --tree
  - id: rng_seed
    type:
      - 'null'
      - int
    doc: "random number generator seed for treetime"
    inputBinding:
      position: 101
      prefix: --rng-seed
  - id: sequence_length
    type:
      - 'null'
      - int
    doc: "length of the sequence, used to calculate expected variation in branch length. Not required if alignment is provided."
    inputBinding:
      position: 101
      prefix: --sequence-length
  - id: aln
    type:
      - 'null'
      - File
    doc: "alignment file (fasta)"
    inputBinding:
      position: 101
      prefix: --aln
  - id: vcf_reference
    type:
      - 'null'
      - File
    doc: "only for vcf input: fasta file of the sequence the VCF was mapped to."
    inputBinding:
      position: 101
      prefix: --vcf-reference
  - id: dates
    type:
      - 'null'
      - File
    doc: "csv file with dates for nodes with 'node_name, date' where date is float (as in 2012.15) or in ISO-format (YYYY-MM-DD)."
    inputBinding:
      position: 101
      prefix: --dates
  - id: name_column
    type:
      - 'null'
      - string
    doc: "label of the column to be used as taxon name"
    inputBinding:
      position: 101
      prefix: --name-column
  - id: date_column
    type:
      - 'null'
      - string
    doc: "label of the column to be used as sampling date"
    inputBinding:
      position: 101
      prefix: --date-column
  - id: clock_rate
    type:
      - 'null'
      - float
    doc: "if specified, the rate of the molecular clock won't be optimized."
    inputBinding:
      position: 101
      prefix: --clock-rate
  - id: clock_std_dev
    type:
      - 'null'
      - float
    doc: "standard deviation of the provided clock rate estimate"
    inputBinding:
      position: 101
      prefix: --clock-std-dev
  - id: branch_length_mode
    type:
      - 'null'
      - string
    doc: "input, joint, marginal or auto"
    inputBinding:
      position: 101
      prefix: --branch-length-mode
  - id: confidence
    type:
      - 'null'
      - boolean
    doc: "estimate confidence intervals of divergence times using the marginal posterior distribution"
    inputBinding:
      position: 101
      prefix: --confidence
  - id: time_marginal
    type:
      - 'null'
      - string
    doc: "false, true, assign, always, only-final or never"
    inputBinding:
      position: 101
      prefix: --time-marginal
  - id: keep_polytomies
    type:
      - 'null'
      - boolean
    doc: "Don't resolve polytomies using temporal information."
    inputBinding:
      position: 101
      prefix: --keep-polytomies
  - id: stochastic_resolve
    type:
      - 'null'
      - boolean
    doc: "Resolve polytomies using a random coalescent tree."
    inputBinding:
      position: 101
      prefix: --stochastic-resolve
  - id: greedy_resolve
    type:
      - 'null'
      - boolean
    doc: "Resolve polytomies greedily."
    inputBinding:
      position: 101
      prefix: --greedy-resolve
  - id: relax
    type:
      - 'null'
      - type: array
        items: float
    doc: "use an autocorrelated molecular clock: strength of the gaussian priors on branch specific rate deviation and the coupling of parent and offspring rates (two values)."
    inputBinding:
      position: 101
      prefix: --relax
  - id: max_iter
    type:
      - 'null'
      - int
    doc: "maximal number of iterations the inference cycle is run"
    inputBinding:
      position: 101
      prefix: --max-iter
  - id: coalescent
    type:
      - 'null'
      - string
    doc: "coalescent time scale; 'opt' and 'skyline' are valid options"
    inputBinding:
      position: 101
      prefix: --coalescent
  - id: n_skyline
    type:
      - 'null'
      - int
    doc: "number of grid points in skyline coalescent model"
    inputBinding:
      position: 101
      prefix: --n-skyline
  - id: gen_per_year
    type:
      - 'null'
      - int
    doc: "number of generations per year - used for estimating N_e in coalescent models"
    inputBinding:
      position: 101
      prefix: --gen-per-year
  - id: n_branches_posterior
    type:
      - 'null'
      - boolean
    doc: "add posterior LH to coalescent model"
    inputBinding:
      position: 101
      prefix: --n-branches-posterior
  - id: plot_tree
    type:
      - 'null'
      - string
    doc: "filename to save the tree plot to (pdf, png or svg)"
    inputBinding:
      position: 101
      prefix: --plot-tree
  - id: plot_rtt
    type:
      - 'null'
      - string
    doc: "filename to save the root-to-tip plot to (pdf, png or svg)"
    inputBinding:
      position: 101
      prefix: --plot-rtt
  - id: tip_labels
    type:
      - 'null'
      - boolean
    doc: "add tip labels"
    inputBinding:
      position: 101
      prefix: --tip-labels
  - id: no_tip_labels
    type:
      - 'null'
      - boolean
    doc: "don't show tip labels"
    inputBinding:
      position: 101
      prefix: --no-tip-labels
  - id: clock_filter
    type:
      - 'null'
      - float
    doc: "ignore tips that don't follow a loose clock; set to 0 to switch off."
    inputBinding:
      position: 101
      prefix: --clock-filter
  - id: clock_filter_method
    type:
      - 'null'
      - string
    doc: "residual or local"
    inputBinding:
      position: 101
      prefix: --clock-filter-method
  - id: reroot
    type:
      - 'null'
      - type: array
        items: string
    doc: "Reroot the tree: 'min_dev', 'least-squares', 'oldest', or node name(s) as outgroup."
    inputBinding:
      position: 101
      prefix: --reroot
  - id: keep_root
    type:
      - 'null'
      - boolean
    doc: "don't reroot the tree"
    inputBinding:
      position: 101
      prefix: --keep-root
  - id: tip_slack
    type:
      - 'null'
      - float
    doc: "excess variance associated with terminal nodes accounting for overdispersion of the molecular clock"
    inputBinding:
      position: 101
      prefix: --tip-slack
  - id: covariation
    type:
      - 'null'
      - boolean
    doc: "Account for covariation when estimating rates or rerooting using root-to-tip regression"
    inputBinding:
      position: 101
      prefix: --covariation
  - id: gtr
    type:
      - 'null'
      - string
    doc: "GTR model to use. '--gtr infer' infers a model from the data."
    inputBinding:
      position: 101
      prefix: --gtr
  - id: gtr_params
    type:
      - 'null'
      - type: array
        items: string
    doc: "GTR parameters as key=value list for the model given by --gtr"
    inputBinding:
      position: 101
      prefix: --gtr-params
  - id: aa
    type:
      - 'null'
      - boolean
    doc: "use aminoacid alphabet"
    inputBinding:
      position: 101
      prefix: --aa
  - id: custom_gtr
    type:
      - 'null'
      - File
    doc: "filename of pre-defined custom GTR model in standard TreeTime format"
    inputBinding:
      position: 101
      prefix: --custom-gtr
  - id: keep_overhangs
    type:
      - 'null'
      - boolean
    doc: "do not fill terminal gaps"
    inputBinding:
      position: 101
      prefix: --keep-overhangs
  - id: zero_based
    type:
      - 'null'
      - boolean
    doc: "zero based mutation indexing"
    inputBinding:
      position: 101
      prefix: --zero-based
  - id: reconstruct_tip_states
    type:
      - 'null'
      - boolean
    doc: "overwrite ambiguous states on tips with the most likely inferred state"
    inputBinding:
      position: 101
      prefix: --reconstruct-tip-states
  - id: report_ambiguous
    type:
      - 'null'
      - boolean
    doc: "include transitions involving ambiguous states"
    inputBinding:
      position: 101
      prefix: --report-ambiguous
  - id: method_anc
    type:
      - 'null'
      - string
    doc: "method for reconstructing ancestral sequences: parsimony, fitch, probabilistic or ml"
    inputBinding:
      position: 101
      prefix: --method-anc
  - id: verbose
    type:
      - 'null'
      - int
    doc: "verbosity of output 0-6"
    inputBinding:
      position: 101
      prefix: --verbose
  - id: outdir
    type:
      - 'null'
      - string
    doc: "directory to write the output to"
    inputBinding:
      position: 101
      prefix: --outdir
outputs:
  - id: stdout
    type: stdout
    doc: "Standard output"
  - id: outdir_dir
    type:
      - 'null'
      - Directory
    doc: "directory with the time tree and reports"
    outputBinding:
      glob: $(inputs.outdir)
stdout: treetime.out
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/treetime:0.11.4--pyhdfd78af_0
