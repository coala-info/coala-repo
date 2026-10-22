cwlVersion: v1.2
class: CommandLineTool
baseCommand: [treesapp, create]
label: treesapp_create
doc: "Create a reference package for TreeSAPP.\n\nTool homepage: https://github.com/hallamlab/TreeSAPP"
inputs:
  - id: fastx_input
    type:
      type: array
      items: File
    doc: "Input file(s) containing DNA or protein sequences in FASTA or FASTQ format"
    inputBinding:
      position: 101
      prefix: --fastx_input
  - id: refpkg_name
    type: string
    doc: "Unique name to be used by TreeSAPP internally (<= 6 characters), for example 'McrA'."
    inputBinding:
      position: 101
      prefix: --refpkg_name
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
  - id: deduplicate
    type:
      - 'null'
      - boolean
    doc: "Deduplicate the input sequences at 99.9 percent similarity."
    inputBinding:
      position: 101
      prefix: --deduplicate
  - id: multiple_alignment
    type:
      - 'null'
      - boolean
    doc: "The FASTA input is also the multiple alignment file to be used."
    inputBinding:
      position: 101
      prefix: --multiple_alignment
  - id: profile
    type:
      - 'null'
      - File
    doc: "An HMM profile representing a specific domain. Domains are excised from input sequences based on hmmsearch alignments."
    inputBinding:
      position: 101
      prefix: --profile
  - id: guarantee
    type:
      - 'null'
      - File
    doc: "A FASTA file containing sequences that need to be included in the tree after all clustering and filtering"
    inputBinding:
      position: 101
      prefix: --guarantee
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
  - id: kind
    type:
      - 'null'
      - string
    doc: "The broad classification of marker gene type: functional or taxonomic. [ DEFAULT = functional ]"
    inputBinding:
      position: 101
      prefix: --kind
  - id: stage
    type:
      - 'null'
      - string
    doc: "The stage(s) to execute: continue, search, lineages, clean, cluster, build, evaluate, support, train or update. [DEFAULT = continue]"
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
  - id: accession2taxid
    type:
      - 'null'
      - File
    doc: "Path to an NCBI accession2taxid file for more rapid accession-to-lineage mapping."
    inputBinding:
      position: 101
      prefix: --accession2taxid
  - id: accession2lin
    type:
      - 'null'
      - File
    doc: "Path to a file that maps sequence accessions to taxonomic lineages, possibly made by `treesapp create`."
    inputBinding:
      position: 101
      prefix: --accession2lin
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
    doc: "Directory with the new reference package and intermediate files"
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/treesapp:0.11.4--py39h2de1943_2
