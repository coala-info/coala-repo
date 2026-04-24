cwlVersion: v1.2
class: CommandLineTool
baseCommand: treetime_clock
label: treetime_clock
doc: "Calculates the root-to-tip regression and quantifies the 'clock-i-ness' of the
  tree. It will reroot the tree to maximize the clock-like signal and recalculate
  branch length unless run with --keep-root.\n\nTool homepage: https://github.com/neherlab/treetime"
inputs:
  - id: allow_negative_rate
    type:
      - 'null'
      - boolean
    doc: By default, rates are forced to be positive. For trees with little 
      temporal signal it is advisable to remove this restriction to achieve 
      essentially mid-point rooting.
    inputBinding:
      position: 101
      prefix: --allow-negative-rate
  - id: aln
    type:
      - 'null'
      - File
    doc: alignment file (fasta)
    inputBinding:
      position: 101
      prefix: --aln
  - id: clock_filter
    type:
      - 'null'
      - float
    doc: ignore tips that don't follow a loose clock, 'clock-filter=number of 
      interquartile ranges from regression (method=`residual`)' or z-score of 
      local clock deviation (method=`local`). Default=4.0, set to 0 to switch 
      off.
    inputBinding:
      position: 101
      prefix: --clock-filter
  - id: clock_filter_method
    type:
      - 'null'
      - string
    doc: Use residuals from global clock (`residual`, default) or local clock 
      deviation (`clock`) to filter out tips that don't follow the clock
    inputBinding:
      position: 101
      prefix: --clock-filter-method
  - id: covariation
    type:
      - 'null'
      - boolean
    doc: Account for covariation when estimating rates or rerooting using 
      root-to-tip regression, default False.
    inputBinding:
      position: 101
      prefix: --covariation
  - id: date_column
    type:
      - 'null'
      - string
    doc: label of the column to be used as sampling date
    inputBinding:
      position: 101
      prefix: --date-column
  - id: dates
    type:
      - 'null'
      - File
    doc: csv file with dates for nodes with 'node_name, date' where date is 
      float (as in 2012.15) or in ISO-format (YYYY-MM-DD). Imprecisely known 
      dates can be specified as '2023-XX-XX' or [2013.2:2013.7]
    inputBinding:
      position: 101
      prefix: --dates
  - id: keep_root
    type:
      - 'null'
      - boolean
    doc: don't reroot the tree. Otherwise, reroot to minimize the the residual 
      of the regression of root-to-tip distance and sampling time
    inputBinding:
      position: 101
      prefix: --keep-root
  - id: name_column
    type:
      - 'null'
      - string
    doc: label of the column to be used as taxon name
    inputBinding:
      position: 101
      prefix: --name-column
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: directory to write the output to
    inputBinding:
      position: 101
      prefix: --outdir
  - id: plot_rtt
    type:
      - 'null'
      - File
    doc: filename to save the plot to. Suffix will determine format (choices 
      pdf, png, svg, default=pdf)
    inputBinding:
      position: 101
      prefix: --plot-rtt
  - id: prune_outliers
    type:
      - 'null'
      - boolean
    doc: remove detected outliers from the output tree
    inputBinding:
      position: 101
      prefix: --prune-outliers
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
      position: 101
      prefix: --reroot
  - id: rng_seed
    type:
      - 'null'
      - int
    doc: random number generator seed for treetime
    inputBinding:
      position: 101
      prefix: --rng-seed
  - id: sequence_length
    type:
      - 'null'
      - int
    doc: length of the sequence, used to calculate expected variation in branch 
      length. Not required if alignment is provided.
    inputBinding:
      position: 101
      prefix: --sequence-length
  - id: tip_slack
    type:
      - 'null'
      - float
    doc: excess variance associated with terminal nodes accounting for 
      overdispersion of the molecular clock
    inputBinding:
      position: 101
      prefix: --tip-slack
  - id: tree
    type: File
    doc: Name of file containing the tree in newick, nexus, or phylip format, 
      the branch length of the tree should be in units of average number of 
      nucleotide or protein substitutions per site. If no file is provided, 
      treetime will attempt to build a tree from the alignment using fasttree, 
      iqtree, or raxml (assuming they are installed).
    inputBinding:
      position: 101
      prefix: --tree
  - id: vcf_reference
    type:
      - 'null'
      - File
    doc: 'only for vcf input: fasta file of the sequence the VCF was mapped to.'
    inputBinding:
      position: 101
      prefix: --vcf-reference
  - id: verbose
    type:
      - 'null'
      - int
    doc: verbosity of output 0-6
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/treetime:0.11.4--pyhdfd78af_0
stdout: treetime_clock.out
