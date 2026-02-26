cwlVersion: v1.2
class: CommandLineTool
baseCommand: parnas
label: parnas
doc: "Phylogenetic mAximum RepreseNtAtion Sampling (PARNAS)\n\nTool homepage: https://github.com/flu-crew/parnas"
inputs:
  - id: aa_alignment
    type:
      - 'null'
      - File
    doc: "Path to amino acid sequence alignment associated with\nthe tree tips."
    inputBinding:
      position: 101
      prefix: --aa
  - id: binary
    type:
      - 'null'
      - boolean
    doc: "To be used with --radius. Instead of covering as much\ndiversity as possible,
      PARNAS will cover as many tips\nas possible within the radius. Each leaf will
      have a\nbinary contribution to the objective: 0 if covered,\nelse its weight."
    inputBinding:
      position: 101
      prefix: --binary
  - id: constrain_fully_regex
    type:
      - 'null'
      - string
    doc: Completely ignore the taxa NOT matching this regex.
    inputBinding:
      position: 101
      prefix: --constrain-fully
  - id: cover
    type:
      - 'null'
      - boolean
    doc: "Choose the best representatives (smallest number) that\ncover all the tips
      within the specified\nradius/threshold. If specified, a --radius or\n--threshold
      argument must be specified as well."
    inputBinding:
      position: 101
      prefix: --cover
  - id: evaluate
    type:
      - 'null'
      - boolean
    doc: "Instead of finding new representatives, evaluate how\ngood are the prior
      representatives specified with \"--\nprior\". This option will ignore any other
      output\noptions and the \"--cover\" flag."
    inputBinding:
      position: 101
      prefix: --evaluate
  - id: exclude_eobj_regex
    type:
      - 'null'
      - string
    doc: "Matching taxa can be selected, but will not contribute\nto the objective
      function. Can be used if one wants to\nselect taxa from a reference set."
    inputBinding:
      position: 101
      prefix: --exclude-obj
  - id: exclude_fully_regex
    type:
      - 'null'
      - string
    doc: Completely ignore the taxa matching this regex.
    inputBinding:
      position: 101
      prefix: --exclude-fully
  - id: exclude_rep_regex
    type:
      - 'null'
      - string
    doc: "Prohibits parnas to choose representatives from the\ntaxa matching this
      regex. However, the excluded taxa\nwill still contribute to the objective function."
    inputBinding:
      position: 101
      prefix: --exclude-rep
  - id: include_prior
    type:
      - 'null'
      - boolean
    doc: "To be used in conjuction with --subtree and --prior to\ninclude the prior
      reps into the output subtree."
    inputBinding:
      position: 101
      prefix: --include-prior
  - id: nt_alignment
    type:
      - 'null'
      - File
    doc: "Path to nucleotide sequence alignment associated with\nthe tree tips."
    inputBinding:
      position: 101
      prefix: --nt
  - id: prior
    type:
      - 'null'
      - string
    doc: "Indicate the previous representatives (if any) with a\nregex. The regex
      should match a full taxon name.\nPARNAS will then select centers that represent\n\
      diversity not covered by the previous representatives."
    inputBinding:
      position: 101
      prefix: --prior
  - id: radius
    type:
      - 'null'
      - float
    doc: "Each representative will \"cover\" all leaves within the\nspecified radius
      on the tree. PARNAS will then choose\nrepresentatives so that the amount of
      uncovered\ndiversity is minimized."
    inputBinding:
      position: 101
      prefix: --radius
  - id: samples
    type:
      - 'null'
      - int
    doc: "Number of representatives to be chosen. This argument\nis required unless
      the --cover option is specified"
    inputBinding:
      position: 101
      prefix: -n
  - id: threshold
    type:
      - 'null'
      - float
    doc: "The sequence similarity threshold that works as\n--radius. For example,
      \"95\" will imply that each\nrepresentative covers all leaves within 5% divergence\n\
      on the tree. To account for sequence divergence,\nparnas will run TreeTime to
      infer ancestral\nsubstitutions along the tree edges and re-weigh the\nedges
      based on the number of sustitutions on them. A\nsequence alignment (--nt or
      --aa) must be specified\nwith this option"
    inputBinding:
      position: 101
      prefix: --threshold
  - id: tree
    type: File
    doc: Path to the input tree in newick or nexus format.
    inputBinding:
      position: 101
      prefix: --tree
  - id: weights
    type:
      - 'null'
      - File
    doc: "A CSV file specifying a weight for some or all taxa.\nThe column names must
      be \"taxon\" and \"weight\". If a\ntaxon is not listed in the file, its weight
      is assumed\nto be 1. Maximum allowed weight is 1000 and weights\nbelow 1e-8
      are considered 0."
    inputBinding:
      position: 101
      prefix: --weights
outputs:
  - id: color_out_path
    type:
      - 'null'
      - File
    doc: "PARNAS will save a colored tree, where the chosen\nrepresentatives are highlighted
      and the tree is color-\npartitioned respective to the representatives. If\n\
      prior centers are specified, they (and the subtrees\nthey represent) will be
      colored red."
    outputBinding:
      glob: $(inputs.color_out_path)
  - id: diversity_csv_path
    type:
      - 'null'
      - File
    doc: "Save diversity scores for all k (number of\nrepresentatives) from 2 to n.
      Can be used to choose\nthe right number of representatives for a dataset."
    outputBinding:
      glob: $(inputs.diversity_csv_path)
  - id: sample_tree_path
    type:
      - 'null'
      - File
    doc: "Prune the tree to the sampled taxa and save to the\nspecified file in NEXUS
      format."
    outputBinding:
      glob: $(inputs.sample_tree_path)
  - id: clusters_path
    type:
      - 'null'
      - File
    doc: "PARNAS will save how it partitioned the tree based on\nthe representatives
      to the specified file. Output is a\ntab-delimited file with lines as <taxon\n\
      name><tab><partition number>."
    outputBinding:
      glob: $(inputs.clusters_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/parnas:0.1.7--pyhdfd78af_0
