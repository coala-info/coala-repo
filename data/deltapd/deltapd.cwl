cwlVersion: v1.2
class: CommandLineTool
baseCommand: deltapd
label: deltapd
doc: "Compares a query phylogenetic tree to a reference tree and identifies outlier
  taxa.\n\nTool homepage: https://github.com/Ecogenomics/DeltaPD"
inputs:
  - id: cpus
    type:
      - 'null'
      - int
    doc: number of CPUs to use
    inputBinding:
      position: 101
      prefix: --cpus
  - id: debug
    type:
      - 'null'
      - boolean
    doc: output debugging information
    inputBinding:
      position: 101
      prefix: --debug
  - id: diff_thresh
    type:
      - 'null'
      - string
    doc: "minimum change to base model to be considered an\n                     \
      \   outlier"
    inputBinding:
      position: 101
      prefix: --diff_thresh
  - id: ete3_scale
    type:
      - 'null'
      - float
    doc: pixels per branch length unit
    inputBinding:
      position: 101
      prefix: --ete3_scale
  - id: influence_thresh
    type:
      - 'null'
      - float
    doc: outlier influence threshold value [0,inf)
    inputBinding:
      position: 101
      prefix: --influence_thresh
  - id: k
    type:
      - 'null'
      - int
    doc: "consider the query taxa represented by the ``k``\n                     \
      \   nearest neighbours for each representative taxon"
    inputBinding:
      position: 101
      prefix: --k
  - id: max_taxa
    type:
      - 'null'
      - int
    doc: "if a ref taxon represents more than this number of qry\n               \
      \         taxa, ignore it"
    inputBinding:
      position: 101
      prefix: --max_taxa
  - id: metadata
    type: File
    doc: path to the metadata file
    inputBinding:
      position: 101
      prefix: --metadata
  - id: msa_file
    type: File
    doc: path to the msa file used to infer the query tree
    inputBinding:
      position: 101
      prefix: --msa_file
  - id: plot
    type:
      - 'null'
      - boolean
    doc: generate outlier plots (slow)
    inputBinding:
      position: 101
      prefix: --plot
  - id: q_tree
    type: File
    doc: path to the query tree
    inputBinding:
      position: 101
      prefix: --q_tree
  - id: qry_sep
    type:
      - 'null'
      - string
    doc: "query taxon separator in query tree, e.g.\n                        taxon___geneid"
    inputBinding:
      position: 101
      prefix: --qry_sep
  - id: r_tree
    type: File
    doc: path to the reference tree
    inputBinding:
      position: 101
      prefix: --r_tree
outputs:
  - id: out_dir
    type: Directory
    doc: path to output directory
    outputBinding:
      glob: $(inputs.out_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deltapd:0.1.5--py39h918f1d6_7
