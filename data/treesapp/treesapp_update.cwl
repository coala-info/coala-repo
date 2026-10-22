cwlVersion: v1.2
class: CommandLineTool
baseCommand: [treesapp, update]
label: treesapp_update
doc: "Update a reference package with assigned sequences.\n\nTool homepage: https://github.com/hallamlab/TreeSAPP"
inputs:
  - id: refpkg_path
    type:
      type: array
      items: File
    doc: "Path to the reference package pickle (.pkl) file(s)."
    inputBinding:
      position: 101
      prefix: --refpkg_path
  - id: treesapp_output
    type: Directory
    doc: "Path to the directory containing TreeSAPP outputs, including sequences to be used for the update."
    inputBinding:
      position: 101
      prefix: --treesapp_output
  - id: cluster
    type:
      - 'null'
      - boolean
    doc: "Cluster input sequences at the proportional similarity indicated by --similarity"
    inputBinding:
      position: 101
      prefix: --cluster
  - id: similarity
    type:
      - 'null'
      - float
    doc: "Proportional similarity (between 0.50 and 1.0) to cluster sequences."
    inputBinding:
      position: 101
      prefix: --similarity
  - id: min_like_weight_ratio
    type:
      - 'null'
      - float
    doc: "The minimum likelihood weight ratio required for an EPA placement. [ DEFAULT = 0.1 ]"
    inputBinding:
      position: 101
      prefix: --min_like_weight_ratio
  - id: max_pendant_length
    type:
      - 'null'
      - float
    doc: "The maximum pendant length distance threshold, beyond which EPA placements are unclassified. [ DEFAULT = Inf ]"
    inputBinding:
      position: 101
      prefix: --max_pendant_length
  - id: max_evol_distance
    type:
      - 'null'
      - float
    doc: "The maximum total evolutionary distance between a query and reference(s), beyond which EPA placements are unclassified. [ DEFAULT = Inf ]"
    inputBinding:
      position: 101
      prefix: --max_evol_distance
  - id: output
    type:
      - 'null'
      - string
    doc: "Path to an output directory [DEFAULT = ./output/]"
    default: output
    inputBinding:
      position: 101
      prefix: --output
  - id: trim_align
    type:
      - 'null'
      - boolean
    doc: "Flag to turn on position masking of the multiple sequence alignment"
    inputBinding:
      position: 101
      prefix: --trim_align
  - id: min_seq_length
    type:
      - 'null'
      - int
    doc: "Minimal sequence length after alignment trimming [DEFAULT = 0]"
    inputBinding:
      position: 101
      prefix: --min_seq_length
  - id: molecule
    type:
      - 'null'
      - string
    doc: "Type of input sequences: prot, dna or rrna. TreeSAPP guesses by default."
    inputBinding:
      position: 101
      prefix: --molecule
  - id: bootstraps
    type:
      - 'null'
      - int
    doc: "The maximum number of bootstrap replicates RAxML-NG should perform using the autoMRE algorithm. [ DEFAULT = 0 ]"
    inputBinding:
      position: 101
      prefix: --bootstraps
  - id: raxml_model
    type:
      - 'null'
      - string
    doc: "The evolutionary model for RAxML-NG to use [ Proteins = LG+G4 | Nucleotides = GTR+G ]"
    inputBinding:
      position: 101
      prefix: --raxml_model
  - id: fast
    type:
      - 'null'
      - boolean
    doc: "Build the tree rapidly, using FastTree."
    inputBinding:
      position: 101
      prefix: --fast
  - id: outdet_align
    type:
      - 'null'
      - boolean
    doc: "Activate outlier detection and removal from multiple sequence alignments using OD-seq."
    inputBinding:
      position: 101
      prefix: --outdet_align
  - id: fastx_input
    type:
      - 'null'
      - type: array
        items: File
    doc: "Candidate reference sequences in FASTA format. Triggers re-training of the reference package if provided."
    inputBinding:
      position: 101
      prefix: --fastx_input
  - id: skip_assign
    type:
      - 'null'
      - boolean
    doc: "The assigned sequences are from a database and their database lineages should be used."
    inputBinding:
      position: 101
      prefix: --skip_assign
  - id: resolve
    type:
      - 'null'
      - boolean
    doc: "Candidate references with better resolved lineages and comparable sequence lengths can replace old references."
    inputBinding:
      position: 101
      prefix: --resolve
  - id: stage
    type:
      - 'null'
      - string
    doc: "The stage(s) to execute: continue, lineages or rebuild. [DEFAULT = continue]"
    inputBinding:
      position: 101
      prefix: --stage
  - id: screen
    type:
      - 'null'
      - string
    doc: "Keywords for including specific taxa in the tree."
    inputBinding:
      position: 101
      prefix: --screen
  - id: filter
    type:
      - 'null'
      - string
    doc: "Keywords for removing specific taxa; the opposite of --screen."
    inputBinding:
      position: 101
      prefix: --filter
  - id: min_taxonomic_rank
    type:
      - 'null'
      - string
    doc: "The minimum taxonomic resolution for reference sequences: r, d, p, c, o, f, g or s. [ DEFAULT = r ]"
    inputBinding:
      position: 101
      prefix: --min_taxonomic_rank
  - id: taxa_lca
    type:
      - 'null'
      - boolean
    doc: "Set taxonomy of representative sequences to LCA of cluster member's taxa. [ --cluster REQUIRED ]"
    inputBinding:
      position: 101
      prefix: --taxa_lca
  - id: taxa_norm
    type:
      - 'null'
      - string
    doc: "[ IN DEVELOPMENT ] Subsample leaves by taxonomic lineage: Rank,number comma-separated."
    inputBinding:
      position: 101
      prefix: --taxa_norm
  - id: seqs2lineage
    type:
      - 'null'
      - File
    doc: "Path to a file mapping sequence names to taxonomic lineages."
    inputBinding:
      position: 101
      prefix: --seqs2lineage
  - id: svm_kernel
    type:
      - 'null'
      - string
    doc: "Kernel type to be used in the SVM algorithm: lin, poly or rbf. [ DEFAULT = lin ]"
    inputBinding:
      position: 101
      prefix: --svm_kernel
  - id: max_examples
    type:
      - 'null'
      - int
    doc: "Limits the number of examples used for training models. [ DEFAULT = 1000 ]"
    inputBinding:
      position: 101
      prefix: --max_examples
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: "Overwrites previously written output files and directories"
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Prints a more verbose runtime log"
    inputBinding:
      position: 101
      prefix: --verbose
  - id: delete
    type:
      - 'null'
      - boolean
    doc: "Delete all intermediate files to save disk space."
    inputBinding:
      position: 101
      prefix: --delete
  - id: num_procs
    type:
      - 'null'
      - int
    doc: "The number of CPU threads or parallel processes to use in various pipeline steps [ DEFAULT = 2 ]"
    inputBinding:
      position: 101
      prefix: --num_procs
  - id: headless
    type:
      - 'null'
      - boolean
    doc: "Do not require any user input during runtime."
    inputBinding:
      position: 101
      prefix: --headless
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: "Updated reference package output directory"
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/treesapp:0.11.4--py39h2de1943_2
