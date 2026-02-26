cwlVersion: v1.2
class: CommandLineTool
baseCommand: treesapp_create
label: treesapp_create
doc: "Create a reference package for TreeSAPP.\n\nTool homepage: https://github.com/hallamlab/TreeSAPP"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: An input file containing DNA or protein sequences in either FASTA or 
      FASTQ format
    inputBinding:
      position: 1
  - id: refpkg_name
    type: string
    doc: "Unique name to be used by TreeSAPP internally. NOTE: Must be <=6 characters.
      Examples are 'McrA', 'DsrAB', and 'p_amoA'."
    inputBinding:
      position: 2
  - id: accession_to_lineage_file
    type:
      - 'null'
      - File
    doc: Path to a file that maps sequence accessions to taxonomic lineages, 
      possibly made by `treesapp create`...
    inputBinding:
      position: 103
      prefix: --accession2lin
  - id: accession_to_taxid_file
    type:
      - 'null'
      - File
    doc: Path to an NCBI accession2taxid file for more rapid 
      accession-to-lineage mapping.
    inputBinding:
      position: 103
      prefix: --accession2taxid
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
  - id: cluster_sequences
    type:
      - 'null'
      - boolean
    doc: Cluster input sequences at the proportional similarity indicated by 
      identity
    inputBinding:
      position: 103
      prefix: --cluster
  - id: deduplicate_sequences
    type:
      - 'null'
      - boolean
    doc: Deduplicate the input sequences at 99.9 percent similarity. This is a 
      pre-processing step to require fewer Entrez queries - clustering at lower 
      resolution with '--cluster' is still suggested.
    inputBinding:
      position: 103
      prefix: --deduplicate
  - id: delete_intermediate_files
    type:
      - 'null'
      - boolean
    doc: Delete all intermediate files to save disk space.
    inputBinding:
      position: 103
      prefix: --delete
  - id: execution_stage
    type:
      - 'null'
      - string
    doc: The stage(s) for TreeSAPP to execute
    default: continue
    inputBinding:
      position: 103
      prefix: --stage
  - id: fast_tree
    type:
      - 'null'
      - boolean
    doc: A flag indicating the tree should be built rapidly, using FastTree.
    inputBinding:
      position: 103
      prefix: --fast
  - id: filter_taxa
    type:
      - 'null'
      - string
    doc: Keywords for removing specific taxa; the opposite of `--screen`.
    inputBinding:
      position: 103
      prefix: --filter
  - id: guarantee_sequences
    type:
      - 'null'
      - File
    doc: A FASTA file containing sequences that need to be included in the tree 
      after all clustering and filtering
    inputBinding:
      position: 103
      prefix: --guarantee
  - id: headless
    type:
      - 'null'
      - boolean
    doc: Do not require any user input during runtime.
    inputBinding:
      position: 103
      prefix: --headless
  - id: hmm_profile
    type:
      - 'null'
      - File
    doc: An HMM profile representing a specific domain. Domains will be excised 
      from input sequences based on hmmsearch alignments.
    inputBinding:
      position: 103
      prefix: --profile
  - id: marker_gene_kind
    type:
      - 'null'
      - string
    doc: The broad classification of marker gene type, either functional or 
      taxonomic.
    default: functional
    inputBinding:
      position: 103
      prefix: --kind
  - id: max_examples
    type:
      - 'null'
      - int
    doc: Limits the number of examples used for training models.
    default: 1000
    inputBinding:
      position: 103
      prefix: --max_examples
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
  - id: molecule_type
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
  - id: outlier_detection_align
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
  - id: screen_taxa
    type:
      - 'null'
      - string
    doc: Keywords for including specific taxa in the tree. To only include 
      Bacteria and Archaea use `--screen Bacteria,Archaea`
    inputBinding:
      position: 103
      prefix: --screen
  - id: seq_name_to_taxa_file
    type:
      - 'null'
      - File
    doc: Path to a file mapping sequence names to taxonomic lineages.
    inputBinding:
      position: 103
      prefix: --seqs2lineage
  - id: seqs2lineage_map
    type:
      - 'null'
      - File
    doc: Path to a file mapping sequence names to taxonomic lineages.
    inputBinding:
      position: 103
      prefix: --seqs2lineage
  - id: similarity_threshold
    type:
      - 'null'
      - float
    doc: Proportional similarity (between 0.50 and 1.0) to cluster sequences.
    inputBinding:
      position: 103
      prefix: --similarity
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
  - id: trim_align
    type:
      - 'null'
      - boolean
    doc: Flag to turn on position masking of the multiple sequence alignment
    default: false
    inputBinding:
      position: 103
      prefix: --trim_align
  - id: use_multiple_alignment
    type:
      - 'null'
      - boolean
    doc: The FASTA input is also the multiple alignment file to be used.
    inputBinding:
      position: 103
      prefix: --multiple_alignment
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
stdout: treesapp_create.out
