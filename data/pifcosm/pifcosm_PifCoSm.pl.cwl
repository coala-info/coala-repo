cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - perl
  - PifCoSm.pl
label: pifcosm_PifCoSm.pl
doc: "PifCoSm (Phylogenetic Information for Community Systematics) is a tool for parsing
  GenBank data, clustering sequences, and performing phylogenetic analysis.\n\nTool
  homepage: https://github.com/RybergGroup/PifCoSm"
inputs:
  - id: batch_file
    type:
      - 'null'
      - File
    doc: Batch file containing commands and options
    inputBinding:
      position: 1
  - id: alignment_format
    type:
      - 'null'
      - string
    doc: Format of output alignment (fasta, phylip, nexus)
    inputBinding:
      position: 102
      prefix: --alignment_format
  - id: anchor_gene
    type:
      - 'null'
      - string
    doc: Anchor gene for catenation or stats
    inputBinding:
      position: 102
      prefix: --anchor_gene
  - id: bases_per_row
    type:
      - 'null'
      - int
    doc: Number of bases per row in alignment
    inputBinding:
      position: 102
      prefix: --bases_per_row
  - id: cat_phylo_method
    type:
      - 'null'
      - string
    doc: Phylogenetic method for catenated tree
    inputBinding:
      position: 102
      prefix: --cat_phylo_method
  - id: change_option
    type:
      - 'null'
      - string
    doc: Option for changing entries
    inputBinding:
      position: 102
      prefix: --change_option
  - id: changes_files
    type:
      - 'null'
      - File
    doc: Files containing annotation changes
    inputBinding:
      position: 102
      prefix: --changes_files
  - id: column_name
    type:
      - 'null'
      - string
    doc: Column name(s) to extract
    inputBinding:
      position: 102
      prefix: --column_name
  - id: comp_columns
    type:
      - 'null'
      - string
    doc: Comparison columns for multimotu
    inputBinding:
      position: 102
      prefix: --comp_columns
  - id: comp_kind
    type:
      - 'null'
      - string
    doc: Comparison kind for multimotu
    inputBinding:
      position: 102
      prefix: --comp_kind
  - id: comp_score
    type:
      - 'null'
      - float
    doc: Comparison score for multimotu
    inputBinding:
      position: 102
      prefix: --comp_score
  - id: create_gene_trees
    type:
      - 'null'
      - boolean
    doc: Create trees for each gene
    inputBinding:
      position: 102
      prefix: --create_gene_trees
  - id: database
    type:
      - 'null'
      - string
    doc: Database name or path
    inputBinding:
      position: 102
      prefix: --database
  - id: e_value_cut_off
    type:
      - 'null'
      - float
    doc: E-value cutoff for HMM matching
    inputBinding:
      position: 102
      prefix: --e_value_cut_off
  - id: gb_file
    type:
      - 'null'
      - File
    doc: GenBank format text file to parse
    inputBinding:
      position: 102
      prefix: --gb_file
  - id: get_taxon
    type:
      - 'null'
      - string
    doc: Taxon to extract trees for
    inputBinding:
      position: 102
      prefix: --get_taxon
  - id: group_on_genera
    type:
      - 'null'
      - boolean
    doc: Define groups to align based on genera
    inputBinding:
      position: 102
      prefix: --group_on_genera
  - id: hmm_database
    type:
      - 'null'
      - File
    doc: HMM database for gene matching
    inputBinding:
      position: 102
      prefix: --hmm_database
  - id: individual_columns
    type:
      - 'null'
      - string
    doc: Columns used to define individuals
    inputBinding:
      position: 102
      prefix: --individual_columns
  - id: individual_condition
    type:
      - 'null'
      - string
    doc: Condition for defining individuals
    inputBinding:
      position: 102
      prefix: --individual_condition
  - id: inter_genes
    type:
      - 'null'
      - string
    doc: Inter-gene settings
    inputBinding:
      position: 102
      prefix: --inter_genes
  - id: interleaved
    type:
      - 'null'
      - boolean
    doc: Use interleaved format for alignment
    inputBinding:
      position: 102
      prefix: --interleaved
  - id: linked_genes
    type:
      - 'null'
      - string
    doc: Specify linked genes to use
    inputBinding:
      position: 102
      prefix: --linked_genes
  - id: max_alignment_group_size
    type:
      - 'null'
      - int
    doc: Maximum size of alignment groups
    inputBinding:
      position: 102
      prefix: --max_alignment_group_size
  - id: max_seq_length
    type:
      - 'null'
      - int
    doc: Maximum sequence length
    inputBinding:
      position: 102
      prefix: --max_seq_length
  - id: maximize_linking
    type:
      - 'null'
      - boolean
    doc: Maximize linking between genes
    inputBinding:
      position: 102
      prefix: --maximize_linking
  - id: min_seq_length_gene
    type:
      - 'null'
      - int
    doc: Minimum sequence length for a gene
    inputBinding:
      position: 102
      prefix: --min_seq_length_gene
  - id: modules
    type:
      - 'null'
      - type: array
        items: string
    doc: Module(s) to run (e.g., gb_parser, gene_parser, etc.)
    inputBinding:
      position: 102
      prefix: --modules
  - id: n_cut_off
    type:
      - 'null'
      - int
    doc: N cutoff value
    inputBinding:
      position: 102
      prefix: --n_cut_off
  - id: only_show
    type:
      - 'null'
      - string
    doc: Filter output to show only specific items
    inputBinding:
      position: 102
      prefix: --only_show
  - id: output_no_rogues_tree
    type:
      - 'null'
      - boolean
    doc: Output tree with rogues removed
    inputBinding:
      position: 102
      prefix: --output_no_rogues_tree
  - id: path
    type:
      - 'null'
      - Directory
    doc: Path for output or working files
    inputBinding:
      position: 102
      prefix: --path
  - id: phylo_method
    type:
      - 'null'
      - string
    doc: Phylogenetic method to use
    inputBinding:
      position: 102
      prefix: --phylo_method
  - id: print_non_match
    type:
      - 'null'
      - boolean
    doc: Print sequences that do not match any HMM
    inputBinding:
      position: 102
      prefix: --print_non_match
  - id: print_rogues
    type:
      - 'null'
      - boolean
    doc: Print identified rogue taxa
    inputBinding:
      position: 102
      prefix: --print_rogues
  - id: remove_outliers
    type:
      - 'null'
      - boolean
    doc: Remove outlier sequences
    inputBinding:
      position: 102
      prefix: --remove_outliers
  - id: rm_rogues_from_alignment
    type:
      - 'null'
      - boolean
    doc: Remove rogues from alignment
    inputBinding:
      position: 102
      prefix: --rm_rogues_from_alignment
  - id: rm_rogues_from_ml_tree
    type:
      - 'null'
      - boolean
    doc: Remove rogues from ML tree
    inputBinding:
      position: 102
      prefix: --rm_rogues_from_ml_tree
  - id: sequence_name_column
    type:
      - 'null'
      - string
    doc: Column to use for sequence names
    inputBinding:
      position: 102
      prefix: --sequence_name_column
  - id: sim_cut_off
    type:
      - 'null'
      - float
    doc: Similarity cutoff for clustering
    inputBinding:
      position: 102
      prefix: --sim_cut_off
  - id: stats_type
    type:
      - 'null'
      - string
    doc: Type of statistics ('cluster' or 'alignment')
    inputBinding:
      position: 102
      prefix: --stats_type
  - id: stop_criterion
    type:
      - 'null'
      - string
    doc: Stop criterion for refinement
    inputBinding:
      position: 102
      prefix: --stop_criterion
  - id: store_boot_trees
    type:
      - 'null'
      - boolean
    doc: Store bootstrap trees
    inputBinding:
      position: 102
      prefix: --store_boot_trees
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 102
      prefix: --threads
  - id: tree_clust_type
    type:
      - 'null'
      - string
    doc: Type of tree clustering
    inputBinding:
      position: 102
      prefix: --tree_clust_type
  - id: tree_file
    type:
      - 'null'
      - File
    doc: Tree file or gene tree
    inputBinding:
      position: 102
      prefix: --tree_file
  - id: tree_infile
    type:
      - 'null'
      - File
    doc: Input tree file for switching names
    inputBinding:
      position: 102
      prefix: --tree_infile
  - id: use_genes
    type:
      - 'null'
      - type: array
        items: string
    doc: Genes to include in the analysis
    inputBinding:
      position: 102
      prefix: --use_genes
  - id: use_guide_tree
    type:
      - 'null'
      - boolean
    doc: Use a guide tree for refinement
    inputBinding:
      position: 102
      prefix: --use_guide_tree
outputs:
  - id: out_file_name
    type:
      - 'null'
      - File
    doc: Output file name
    outputBinding:
      glob: $(inputs.out_file_name)
  - id: partition_file
    type:
      - 'null'
      - File
    doc: Output partition file
    outputBinding:
      glob: $(inputs.partition_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pifcosm:0.1.1--hdfd78af_0
