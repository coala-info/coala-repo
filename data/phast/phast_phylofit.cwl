cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phyloFit
label: phast_phylofit
doc: "Fits one or more tree models to a multiple alignment of DNA sequences by maximum likelihood,\
  \ using the specified tree topology and substitution model. If categories of sites are defined\
  \ via --features and --catmap, a separate model is estimated for each category. Each model\
  \ is written to a file with the suffix \".mod\".\n\nTool homepage: http://compgen.cshl.edu/phast/"
inputs:
  - id: tree
    type:
      - 'null'
      - string
    doc: Tree topology as a Newick string, e.g. "(human,(mouse,rat))".
    inputBinding:
      position: 1
      prefix: --tree
  - id: tree_file
    type:
      - 'null'
      - File
    doc: Tree topology as a Newick file (use instead of tree).
    inputBinding:
      position: 1
      prefix: --tree
  - id: subst_mod
    type:
      - 'null'
      - string
    doc: 'Substitution model: JC69, F81, HKY85, HKY85+Gap, REV, SSREV, UNREST, R2, R2S, U2,
      U2S, R3, R3S, U3 or U3S (default REV).'
    inputBinding:
      position: 1
      prefix: --subst-mod
  - id: msa_format
    type:
      - 'null'
      - string
    doc: 'Alignment format: FASTA, PHYLIP, MPM, MAF or SS (default guess from contents).'
    inputBinding:
      position: 1
      prefix: --msa-format
  - id: out_root
    type:
      - 'null'
      - string
    doc: Root filename for all files created (default "phyloFit").
    default: phyloFit
    inputBinding:
      position: 1
      prefix: --out-root
  - id: min_informative
    type:
      - 'null'
      - int
    doc: Require at least this many informative sites (default 50).
    inputBinding:
      position: 1
      prefix: --min-informative
  - id: gaps_as_bases
    type:
      - 'null'
      - boolean
    doc: Treat alignment gap characters like ordinary bases.
    inputBinding:
      position: 1
      prefix: --gaps-as-bases
  - id: ignore_branches
    type:
      - 'null'
      - string
    doc: Comma-separated list of nodes whose branches are ignored.
    inputBinding:
      position: 1
      prefix: --ignore-branches
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of OpenMP threads.
    inputBinding:
      position: 1
      prefix: --threads
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Proceed quietly.
    inputBinding:
      position: 1
      prefix: --quiet
  - id: lnl
    type:
      - 'null'
      - boolean
    doc: (With --init-model) Evaluate the log likelihood of the model without further optimization.
    inputBinding:
      position: 1
      prefix: --lnl
  - id: em
    type:
      - 'null'
      - boolean
    doc: Fit model(s) using EM rather than BFGS.
    inputBinding:
      position: 1
      prefix: --EM
  - id: precision
    type:
      - 'null'
      - string
    doc: 'Precision of estimation: HIGH, MED or LOW (default HIGH).'
    inputBinding:
      position: 1
      prefix: --precision
  - id: log
    type:
      - 'null'
      - string
    doc: Write a log of the optimization procedure to this file.
    inputBinding:
      position: 1
      prefix: --log
  - id: init_model
    type:
      - 'null'
      - File
    doc: Initialize with this tree model (.mod). Not allowed with --tree.
    inputBinding:
      position: 1
      prefix: --init-model
  - id: init_random
    type:
      - 'null'
      - boolean
    doc: Initialize parameters randomly.
    inputBinding:
      position: 1
      prefix: --init-random
  - id: seed
    type:
      - 'null'
      - int
    doc: Random number seed (integer >= 1).
    inputBinding:
      position: 1
      prefix: --seed
  - id: init_parsimony
    type:
      - 'null'
      - boolean
    doc: Initialize branch lengths using parsimony counts.
    inputBinding:
      position: 1
      prefix: --init-parsimony
  - id: print_parsimony
    type:
      - 'null'
      - string
    doc: Print parsimony score to this file, and quit.
    inputBinding:
      position: 1
      prefix: --print-parsimony
  - id: clock
    type:
      - 'null'
      - boolean
    doc: Assume a molecular clock in estimation.
    inputBinding:
      position: 1
      prefix: --clock
  - id: scale_only
    type:
      - 'null'
      - boolean
    doc: (With --init-model) Estimate only the scale of the tree.
    inputBinding:
      position: 1
      prefix: --scale-only
  - id: scale_subtree
    type:
      - 'null'
      - string
    doc: (With --scale-only) Estimate a separate scale factor for the subtree beneath this
      node.
    inputBinding:
      position: 1
      prefix: --scale-subtree
  - id: estimate_freqs
    type:
      - 'null'
      - boolean
    doc: Estimate equilibrium frequencies by maximum likelihood.
    inputBinding:
      position: 1
      prefix: --estimate-freqs
  - id: sym_freqs
    type:
      - 'null'
      - boolean
    doc: Estimate equilibrium frequencies assuming freq(A)=freq(T) and freq(C)=freq(G).
    inputBinding:
      position: 1
      prefix: --sym-freqs
  - id: no_freqs
    type:
      - 'null'
      - boolean
    doc: (With --init-model) Do not estimate equilibrium frequencies.
    inputBinding:
      position: 1
      prefix: --no-freqs
  - id: no_rates
    type:
      - 'null'
      - boolean
    doc: (With --init-model) Do not estimate rate-matrix parameters.
    inputBinding:
      position: 1
      prefix: --no-rates
  - id: ancestor
    type:
      - 'null'
      - string
    doc: Treat this sequence as the root of the tree.
    inputBinding:
      position: 1
      prefix: --ancestor
  - id: error
    type:
      - 'null'
      - string
    doc: Report estimate, variance and 95% confidence interval of each parameter to this file.
    inputBinding:
      position: 1
      prefix: --error
  - id: no_opt
    type:
      - 'null'
      - string
    doc: Comma-separated list of parameters held constant (e.g. branches, ratematrix, backgd,
      ratevar, kappa).
    inputBinding:
      position: 1
      prefix: --no-opt
  - id: bound
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --bound
    doc: Parameter boundaries, e.g. gc_param[1,]. Can be given several times.
    inputBinding:
      position: 1
  - id: selection
    type:
      - 'null'
      - float
    doc: Use selection in the model with this selection parameter.
    inputBinding:
      position: 1
      prefix: --selection
  - id: nrates
    type:
      - 'null'
      - int
    doc: Number of rate categories (default 1).
    inputBinding:
      position: 1
      prefix: --nrates
  - id: alpha
    type:
      - 'null'
      - float
    doc: (With --nrates) Initial value for the gamma shape parameter alpha (default 1).
    inputBinding:
      position: 1
      prefix: --alpha
  - id: rate_constants
    type:
      - 'null'
      - string
    doc: Comma-separated rate constants for a non-parametric rate mixture model.
    inputBinding:
      position: 1
      prefix: --rate-constants
  - id: features
    type:
      - 'null'
      - File
    doc: Annotations file (GFF or BED) defining site categories.
    inputBinding:
      position: 1
      prefix: --features
  - id: catmap
    type:
      - 'null'
      - string
    doc: Inline category map, e.g. "NCATS = 3 ; CDS 1-3".
    inputBinding:
      position: 1
      prefix: --catmap
  - id: catmap_file
    type:
      - 'null'
      - File
    doc: Category map file (use instead of catmap).
    inputBinding:
      position: 1
      prefix: --catmap
  - id: do_cats
    type:
      - 'null'
      - string
    doc: (With --features) Estimate models only for these categories.
    inputBinding:
      position: 1
      prefix: --do-cats
  - id: reverse_groups
    type:
      - 'null'
      - string
    doc: (With --features) Group features by this tag and reverse complement groups on the
      reverse strand.
    inputBinding:
      position: 1
      prefix: --reverse-groups
  - id: markov
    type:
      - 'null'
      - boolean
    doc: (Context-dependent models) Assume Markov dependence of alignment columns.
    inputBinding:
      position: 1
      prefix: --markov
  - id: non_overlapping
    type:
      - 'null'
      - boolean
    doc: (Context-dependent models) Avoid overlapping tuples of sites.
    inputBinding:
      position: 1
      prefix: --non-overlapping
  - id: label_branches
    type:
      - 'null'
      - string
    doc: 'Label a group of branches: branch1,branch2,...:label.'
    inputBinding:
      position: 1
      prefix: --label-branches
  - id: label_subtree
    type:
      - 'null'
      - string
    doc: 'Label a subtree: node[+]:label.'
    inputBinding:
      position: 1
      prefix: --label-subtree
  - id: alt_model
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --alt-model
    doc: 'Lineage-specific model: label:(model|param_list). Can be given several times.'
    inputBinding:
      position: 1
  - id: post_probs
    type:
      - 'null'
      - boolean
    doc: Output posterior probabilities of all bases at all ancestral nodes (.postprob).
    inputBinding:
      position: 1
      prefix: --post-probs
  - id: expected_subs
    type:
      - 'null'
      - boolean
    doc: Output posterior expected number of substitutions per branch and site (.expsub).
    inputBinding:
      position: 1
      prefix: --expected-subs
  - id: expected_subs_col
    type:
      - 'null'
      - boolean
    doc: Output posterior expected number of substitutions of each type per branch and site
      (.expcolsub).
    inputBinding:
      position: 1
      prefix: --expected-subs-col
  - id: expected_total_subs
    type:
      - 'null'
      - boolean
    doc: Output posterior expected number of substitutions of each type per branch, summed
      over sites (.exptotsub).
    inputBinding:
      position: 1
      prefix: --expected-total-subs
  - id: column_probs
    type:
      - 'null'
      - boolean
    doc: (With --init-model) Output a log probability for each column type (.colprobs).
    inputBinding:
      position: 1
      prefix: --column-probs
  - id: windows
    type:
      - 'null'
      - string
    doc: 'Sliding window: size,shift.'
    inputBinding:
      position: 1
      prefix: --windows
  - id: windows_explicit
    type:
      - 'null'
      - string
    doc: Explicit list of window start and end coordinates.
    inputBinding:
      position: 1
      prefix: --windows-explicit
  - id: alignment
    type: File
    doc: Multiple alignment (FASTA or another format, see --msa-format).
    inputBinding:
      position: 2
outputs:
  - id: models
    type:
      type: array
      items: File
    doc: Fitted tree models (.mod) and auxiliary files written with the output root.
    outputBinding:
      glob: $(inputs.out_root)*
  - id: log_file
    type:
      - 'null'
      - File
    doc: Optimization log.
    outputBinding:
      glob: $(inputs.log)
  - id: error_file
    type:
      - 'null'
      - File
    doc: Parameter estimates with confidence intervals.
    outputBinding:
      glob: $(inputs.error)
  - id: parsimony_file
    type:
      - 'null'
      - File
    doc: Parsimony score.
    outputBinding:
      glob: $(inputs.print_parsimony)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phast:1.9.7--h7eac25e_0
