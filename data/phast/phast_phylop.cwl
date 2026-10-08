cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phyloP
label: phast_phylop
doc: "Compute conservation or acceleration p-values based on an alignment and a model of neutral\
  \ evolution. Will also compute p-values of conservation/acceleration in a subtree and in\
  \ its complementary supertree given the whole tree. P-values can be produced for entire\
  \ input alignments, pre-specified intervals within an alignment, or individual sites.\n\n\
  Tool homepage: http://compgen.cshl.edu/phast/"
inputs:
  - id: msa_format
    type:
      - 'null'
      - string
    doc: 'Alignment format: FASTA, PHYLIP, MPM, MAF or SS (default guess from contents).'
    inputBinding:
      position: 1
      prefix: --msa-format
  - id: method
    type:
      - 'null'
      - string
    doc: 'Method for p-values or scores: SPH, LRT, SCORE or GERP (default SPH).'
    inputBinding:
      position: 1
      prefix: --method
  - id: wig_scores
    type:
      - 'null'
      - boolean
    doc: Output base-by-base scores (-log10 p) in fixed-step wig format.
    inputBinding:
      position: 1
      prefix: --wig-scores
  - id: base_by_base
    type:
      - 'null'
      - boolean
    doc: Like --wig-scores, but output multiple method-dependent values per site.
    inputBinding:
      position: 1
      prefix: --base-by-base
  - id: refidx
    type:
      - 'null'
      - int
    doc: (With --wig-scores or --base-by-base) Coordinate frame sequence; 0 means the whole
      alignment. Default 1.
    inputBinding:
      position: 1
      prefix: --refidx
  - id: mode
    type:
      - 'null'
      - string
    doc: CON, ACC, NNEUT or CONACC (default CON).
    inputBinding:
      position: 1
      prefix: --mode
  - id: features
    type:
      - 'null'
      - File
    doc: Features (GFF or BED); output one row of p-values per feature.
    inputBinding:
      position: 1
      prefix: --features
  - id: gff_scores
    type:
      - 'null'
      - boolean
    doc: (With --features) Output a GFF with each feature scored by its -log10 p-value.
    inputBinding:
      position: 1
      prefix: --gff-scores
  - id: subtree
    type:
      - 'null'
      - string
    doc: Test conservation/acceleration in the subtree beneath this node given the supertree.
    inputBinding:
      position: 1
      prefix: --subtree
  - id: branch
    type:
      - 'null'
      - string
    doc: Comma-separated list of branches (named by child node) to test against the rest of
      the tree.
    inputBinding:
      position: 1
      prefix: --branch
  - id: chrom
    type:
      - 'null'
      - string
    doc: (With --wig-scores or --base-by-base) Chromosome name for wig output.
    inputBinding:
      position: 1
      prefix: --chrom
  - id: log
    type:
      - 'null'
      - string
    doc: Write a log of parameter optimization to this file.
    inputBinding:
      position: 1
      prefix: --log
  - id: seed
    type:
      - 'null'
      - int
    doc: Random number seed (integer >= 1).
    inputBinding:
      position: 1
      prefix: --seed
  - id: no_prune
    type:
      - 'null'
      - boolean
    doc: Do not prune species from the tree that are not in the alignment.
    inputBinding:
      position: 1
      prefix: --no-prune
  - id: null_sites
    type:
      - 'null'
      - int
    doc: (SPH) Compute just the null distribution of the number of substitutions for this
      many sites.
    inputBinding:
      position: 1
      prefix: --null
  - id: posterior
    type:
      - 'null'
      - boolean
    doc: (SPH) Compute just the posterior distribution of the number of substitutions.
    inputBinding:
      position: 1
      prefix: --posterior
  - id: fit_model
    type:
      - 'null'
      - boolean
    doc: (SPH) Fit a scale factor to the data before computing the posterior distribution.
    inputBinding:
      position: 1
      prefix: --fit-model
  - id: epsilon
    type:
      - 'null'
      - double
    doc: (SPH) Threshold for truncating distribution tails (default 1e-10, or 1e-6 with --wig-scores/--base-by-base).
    inputBinding:
      position: 1
      prefix: --epsilon
  - id: confidence_interval
    type:
      - 'null'
      - float
    doc: (SPH) Use a central confidence interval of this size (0 < val < 1) around the mean.
    inputBinding:
      position: 1
      prefix: --confidence-interval
  - id: quantiles
    type:
      - 'null'
      - boolean
    doc: (With --null or --posterior) Report quantiles rather than the whole distribution.
    inputBinding:
      position: 1
      prefix: --quantiles
  - id: tree_mod
    type: File
    doc: Neutral tree model in .mod format (from phyloFit).
    inputBinding:
      position: 2
  - id: alignment
    type:
      - 'null'
      - File
    doc: Alignment file (not needed with --null).
    inputBinding:
      position: 3
  - id: output_name
    type:
      - 'null'
      - string
    doc: Name of the result file (standard output).
    default: phyloP.out
outputs:
  - id: result
    type: File
    doc: p-values, scores or distributions.
    outputBinding:
      glob: $(inputs.output_name)
  - id: log_file
    type:
      - 'null'
      - File
    doc: Optimization log.
    outputBinding:
      glob: $(inputs.log)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phast:1.9.7--h7eac25e_0
stdout: $(inputs.output_name)
