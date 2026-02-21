cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyml
label: phyml
doc: "A simple, fast, and accurate algorithm to estimate large phylogenies by maximum
  likelihood\n\nTool homepage: http://www.atgc-montpellier.fr/phyml/"
inputs:
  - id: aa_rate_file
    type:
      - 'null'
      - File
    doc: File that provides the amino acid substitution rate matrix in PAML format.
    inputBinding:
      position: 101
      prefix: --aa_rate_file
  - id: alias_subpatt
    type:
      - 'null'
      - boolean
    doc: Site aliasing is generalized at the subtree level.
    inputBinding:
      position: 101
      prefix: --alias_subpatt
  - id: alpha
    type:
      - 'null'
      - string
    doc: Distribution of the gamma distribution shape parameter. Fixed value or 'e'.
    inputBinding:
      position: 101
      prefix: --alpha
  - id: boot_progress_display
    type:
      - 'null'
      - int
    doc: Frequency at which the bootstrap progress bar will be updated.
    default: 20
    inputBinding:
      position: 101
      prefix: --boot_progress_display
  - id: bootstrap
    type:
      - 'null'
      - int
    doc: 'Number of bootstrap replicates or type of branch support (0: none, -1: aLRT,
      -2: Chi2, -4: SH-like, -5: Bayes).'
    default: -5
    inputBinding:
      position: 101
      prefix: --bootstrap
  - id: datatype
    type:
      - 'null'
      - string
    doc: "Data type: 'nt' for nucleotide, 'aa' for amino-acid sequences, or 'generic'."
    default: nt
    inputBinding:
      position: 101
      prefix: --datatype
  - id: freerates
    type:
      - 'null'
      - boolean
    doc: FreeRate model of substitution rate variation across sites.
    inputBinding:
      position: 101
      prefix: --freerates
  - id: frequencies
    type:
      - 'null'
      - string
    doc: "Character frequencies: 'e', 'm', 'o' or 'fA,fC,fG,fT'."
    inputBinding:
      position: 101
      prefix: -f
  - id: input
    type: File
    doc: Name of the nucleotide or amino-acid sequence file in PHYLIP format.
    inputBinding:
      position: 101
      prefix: --input
  - id: inputtree
    type:
      - 'null'
      - File
    doc: Starting tree filename in Newick format.
    inputBinding:
      position: 101
      prefix: --inputtree
  - id: leave_duplicates
    type:
      - 'null'
      - boolean
    doc: PhyML removes duplicate sequences by default. Use this option to leave them
      in.
    inputBinding:
      position: 101
      prefix: --leave_duplicates
  - id: model
    type:
      - 'null'
      - string
    doc: Substitution model name (e.g., HKY85, GTR, LG, WAG, JTT, etc.).
    inputBinding:
      position: 101
      prefix: --model
  - id: multiple
    type:
      - 'null'
      - int
    doc: Number of data sets to analyse.
    inputBinding:
      position: 101
      prefix: --multiple
  - id: n_rand_starts
    type:
      - 'null'
      - int
    doc: Number of initial random trees to be used. Only valid for SPR searches.
    inputBinding:
      position: 101
      prefix: --n_rand_starts
  - id: nclasses
    type:
      - 'null'
      - int
    doc: Number of relative substitution rate categories.
    default: 4
    inputBinding:
      position: 101
      prefix: --nclasses
  - id: no_memory_check
    type:
      - 'null'
      - boolean
    doc: No interactive question for memory usage.
    inputBinding:
      position: 101
      prefix: --no_memory_check
  - id: optimise
    type:
      - 'null'
      - string
    doc: Specific parameter optimisation (tlr, tl, lr, l, r, n).
    inputBinding:
      position: 101
      prefix: -o
  - id: pars
    type:
      - 'null'
      - boolean
    doc: Use a minimum parsimony starting tree.
    inputBinding:
      position: 101
      prefix: --pars
  - id: pinv
    type:
      - 'null'
      - string
    doc: Proportion of invariable sites. Fixed value [0,1] or 'e'.
    inputBinding:
      position: 101
      prefix: --pinv
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: No interactive question and quiet output.
    inputBinding:
      position: 101
      prefix: --quiet
  - id: r_seed
    type:
      - 'null'
      - int
    doc: Seed used to initiate the random number generator.
    inputBinding:
      position: 101
      prefix: --r_seed
  - id: rand_start
    type:
      - 'null'
      - boolean
    doc: Sets the initial tree to random. Only valid for SPR searches.
    inputBinding:
      position: 101
      prefix: --rand_start
  - id: run_id
    type:
      - 'null'
      - string
    doc: Append the string ID_string at the end of each PhyML output file.
    inputBinding:
      position: 101
      prefix: --run_id
  - id: search
    type:
      - 'null'
      - string
    doc: Tree topology search operation option (NNI, SPR, or BEST).
    default: NNI
    inputBinding:
      position: 101
      prefix: --search
  - id: sequential
    type:
      - 'null'
      - boolean
    doc: Changes interleaved format (default) to sequential format.
    inputBinding:
      position: 101
      prefix: --sequential
  - id: tbe
    type:
      - 'null'
      - boolean
    doc: Computes TBE instead of FBP (standard) bootstrap support. Has no effect with
      -b <= 0.
    inputBinding:
      position: 101
      prefix: --tbe
  - id: ts_tv_ratio
    type:
      - 'null'
      - string
    doc: Transition/transversion ratio. DNA sequences only. Fixed value or 'e'.
    inputBinding:
      position: 101
      prefix: --ts/tv
outputs:
  - id: print_site_lnl
    type:
      - 'null'
      - File
    doc: Print the likelihood for each site in file *_phyml_lk.txt.
    outputBinding:
      glob: $(inputs.print_site_lnl)
  - id: print_trace
    type:
      - 'null'
      - File
    doc: Print each phylogeny explored during the tree search process in file *_phyml_trace.txt.
    outputBinding:
      glob: $(inputs.print_trace)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyml:3.3.20220408--h9bc3f66_3
