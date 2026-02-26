cwlVersion: v1.2
class: CommandLineTool
baseCommand: treesapp_update
label: treesapp_update
doc: "Update a reference package with assigned sequences.\n\nTool homepage: https://github.com/hallamlab/TreeSAPP"
inputs:
  - id: input
    type:
      - 'null'
      - type: array
        items: File
    doc: An input file containing candidate reference sequences in either FASTA 
      format. Will trigger re-training the reference package if provided.
    inputBinding:
      position: 1
  - id: pkg_path
    type:
      type: array
      items: File
    doc: Path to the reference package pickle (.pkl) file.
    inputBinding:
      position: 2
  - id: bootstraps
    type:
      - 'null'
      - int
    doc: The maximum number of bootstrap replicates RAxML-NG should perform 
      using the autoMRE algorithm.
    default: 0
    inputBinding:
      position: 103
      prefix: --bootstraps
  - id: cluster
    type:
      - 'null'
      - boolean
    doc: Cluster input sequences at the proportional similarity indicated by 
      identity
    inputBinding:
      position: 103
      prefix: --cluster
  - id: delete
    type:
      - 'null'
      - boolean
    doc: Delete all intermediate files to save disk space.
    inputBinding:
      position: 103
      prefix: --delete
  - id: fast
    type:
      - 'null'
      - boolean
    doc: A flag indicating the tree should be built rapidly, using FastTree.
    inputBinding:
      position: 103
      prefix: --fast
  - id: filter
    type:
      - 'null'
      - string
    doc: Keywords for removing specific taxa; the opposite of `--screen`.
    inputBinding:
      position: 103
      prefix: --filter
  - id: headless
    type:
      - 'null'
      - boolean
    doc: Do not require any user input during runtime.
    inputBinding:
      position: 103
      prefix: --headless
  - id: max_evol_distance
    type:
      - 'null'
      - float
    doc: The maximum total evolutionary distance between a query and 
      reference(s), beyond which EPA placements are unclassified.
    default: Inf
    inputBinding:
      position: 103
      prefix: --max_evol_distance
  - id: max_examples
    type:
      - 'null'
      - int
    doc: Limits the number of examples used for training models.
    default: 1000
    inputBinding:
      position: 103
      prefix: --max_examples
  - id: max_pendant_length
    type:
      - 'null'
      - float
    doc: The maximum pendant length distance threshold, beyond which EPA 
      placements are unclassified.
    default: Inf
    inputBinding:
      position: 103
      prefix: --max_pendant_length
  - id: min_like_weight_ratio
    type:
      - 'null'
      - float
    doc: The minimum likelihood weight ratio required for an EPA placement.
    default: 0.1
    inputBinding:
      position: 103
      prefix: --min_like_weight_ratio
  - id: min_seq_length
    type:
      - 'null'
      - int
    doc: minimal sequence length after alignment trimming
    default: 0
    inputBinding:
      position: 103
      prefix: --min_seq_length
  - id: min_taxonomic_rank
    type:
      - 'null'
      - string
    doc: The minimum taxonomic resolution for reference sequences
    default: r
    inputBinding:
      position: 103
      prefix: --min_taxonomic_rank
  - id: molecule
    type:
      - 'null'
      - string
    doc: Type of input sequences (prot = protein; dna = nucleotide; rrna = 
      rRNA). TreeSAPP will guess by default but this may be required if 
      ambiguous.
    inputBinding:
      position: 103
      prefix: --molecule
  - id: num_threads
    type:
      - 'null'
      - int
    doc: The number of CPU threads or parallel processes to use in various 
      pipeline steps
    default: 2
    inputBinding:
      position: 103
      prefix: --num_procs
  - id: outdet_align
    type:
      - 'null'
      - boolean
    doc: Flag to activate outlier detection and removal from multiple sequence 
      alignments using OD-seq.
    default: false
    inputBinding:
      position: 103
      prefix: --outdet_align
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Path to an output directory
    default: ./output/
    inputBinding:
      position: 103
      prefix: --output
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrites previously written output files and directories
    inputBinding:
      position: 103
      prefix: --overwrite
  - id: raxml_model
    type:
      - 'null'
      - string
    doc: The evolutionary model for RAxML-NG to use [ Proteins = LG+G4 | 
      Nucleotides = GTR+G ]
    inputBinding:
      position: 103
      prefix: --raxml_model
  - id: resolve
    type:
      - 'null'
      - boolean
    doc: Flag indicating candidate references with better resolved lineages and 
      comparable sequence lengths can replace old references. Useful when 
      updating with sequences from isolates, SAGs and quality MAGs.
    inputBinding:
      position: 103
      prefix: --resolve
  - id: screen
    type:
      - 'null'
      - string
    doc: Keywords for including specific taxa in the tree. To only include 
      Bacteria and Archaea use `--screen Bacteria,Archaea`
    inputBinding:
      position: 103
      prefix: --screen
  - id: seq_names_to_taxa
    type:
      - 'null'
      - File
    doc: Path to a file mapping sequence names to taxonomic lineages.
    inputBinding:
      position: 103
      prefix: --seqs2lineage
  - id: seqs2lineage
    type:
      - 'null'
      - File
    doc: Path to a file mapping sequence names to taxonomic lineages.
    inputBinding:
      position: 103
      prefix: --seqs2lineage
  - id: similarity
    type:
      - 'null'
      - float
    doc: Proportional similarity (between 0.50 and 1.0) to cluster sequences.
    inputBinding:
      position: 103
      prefix: --similarity
  - id: skip_assign
    type:
      - 'null'
      - boolean
    doc: The assigned sequences are from a database and their database lineages 
      should be used instead of the TreeSAPP-assigned lineages.
    inputBinding:
      position: 103
      prefix: --skip_assign
  - id: stage
    type:
      - 'null'
      - string
    doc: The stage(s) for TreeSAPP to execute
    default: continue
    inputBinding:
      position: 103
      prefix: --stage
  - id: svm_kernel
    type:
      - 'null'
      - string
    doc: Specifies the kernel type to be used in the SVM algorithm. It must be 
      either 'lin' 'poly' or 'rbf'.
    default: lin
    inputBinding:
      position: 103
      prefix: --svm_kernel
  - id: taxa_lca
    type:
      - 'null'
      - boolean
    doc: Set taxonomy of representative sequences to LCA of cluster member's 
      taxa. [ --cluster REQUIRED ]
    inputBinding:
      position: 103
      prefix: --taxa_lca
  - id: taxa_norm
    type:
      - 'null'
      - string
    doc: '[ IN DEVELOPMENT ] Subsample leaves by taxonomic lineage. A comma-separated
      argument with the Rank (e.g. Phylum) and number of representatives is required.'
    inputBinding:
      position: 103
      prefix: --taxa_norm
  - id: treesapp_output
    type: Directory
    doc: Path to the directory containing TreeSAPP outputs, including sequences 
      to be used for the update.
    inputBinding:
      position: 103
      prefix: --treesapp_output
  - id: trim_align
    type:
      - 'null'
      - boolean
    doc: Flag to turn on position masking of the multiple sequence alignment
    default: false
    inputBinding:
      position: 103
      prefix: --trim_align
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Prints a more verbose runtime log
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/treesapp:0.11.4--py39h2de1943_2
stdout: treesapp_update.out
