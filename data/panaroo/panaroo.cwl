cwlVersion: v1.2
class: CommandLineTool
baseCommand: panaroo
label: panaroo
doc: "an updated pipeline for pangenome investigation\n\nTool homepage: https://gtonkinhill.github.io/panaroo"
inputs:
  - id: aligner
    type:
      - 'null'
      - string
    doc: "Specify an aligner. Options:'prank', 'clustal', and\n                  \
      \      default: 'mafft'"
    default: mafft
    inputBinding:
      position: 101
      prefix: --aligner
  - id: alignment
    type:
      - 'null'
      - string
    doc: "Output alignments of core genes or all genes. Options\n                \
      \        are 'core' and 'pan'. Default: 'None'"
    inputBinding:
      position: 101
      prefix: --alignment
  - id: all_seq_in_graph
    type:
      - 'null'
      - boolean
    doc: "Retains all DNA sequence for each gene cluster in the\n                \
      \        graph output. Off by default as it uses a large amount\n          \
      \              of space."
    inputBinding:
      position: 101
      prefix: --all_seq_in_graph
  - id: clean_mode
    type: string
    doc: "The stringency mode at which to run panaroo. Must be\n                 \
      \       one of 'strict','moderate' or 'sensitive'. Each of\n               \
      \         these modes can be fine tuned using the additional\n             \
      \           parameters in the 'Graph correction' section.\n                \
      \        \n                        strict:\n                        Requires
      fairly strong evidence (present in  at least\n                        5% of
      genomes) to keep likely contaminant genes. Will\n                        remove
      genes that are refound more often than they were\n                        called
      originally.\n                        \n                        moderate:\n \
      \                       Requires moderate evidence (present in  at least 1%
      of\n                        genomes) to keep likely contaminant genes. Keeps
      genes\n                        that are refound more often than they were called\n\
      \                        originally.\n                        \n           \
      \             sensitive:\n                        Does not delete any genes
      and only performes merge and\n                        refinding operations.
      Useful if rare plasmids are of\n                        interest as these are
      often hard to disguish from\n                        contamination. Results
      will likely include  higher\n                        number of spurious annotations."
    inputBinding:
      position: 101
      prefix: --clean-mode
  - id: codon_table
    type:
      - 'null'
      - int
    doc: the codon table to use for translation
    default: 11
    inputBinding:
      position: 101
      prefix: --codon-table
  - id: codons
    type:
      - 'null'
      - boolean
    doc: "Generate codon alignments by aligning sequences at the\n               \
      \         protein level"
    inputBinding:
      position: 101
      prefix: --codons
  - id: core_entropy_filter
    type:
      - 'null'
      - float
    doc: "Manually set the Block Mapping and Gathering with\n                    \
      \    Entropy (BMGE) filter. Can be between 0.0 and 1.0. By\n               \
      \         default this is set using the Tukey outlier method."
    inputBinding:
      position: 101
      prefix: --core_entropy_filter
  - id: core_subset
    type:
      - 'null'
      - int
    doc: "Randomly subset the core genome to these many genes\n                  \
      \      (default=all)"
    default: all
    inputBinding:
      position: 101
      prefix: --core_subset
  - id: core_threshold
    type:
      - 'null'
      - float
    doc: Core-genome sample threshold
    default: 0.95
    inputBinding:
      position: 101
      prefix: --core_threshold
  - id: edge_support_threshold
    type:
      - 'null'
      - int
    doc: "minimum support required to keep an edge that has been\n               \
      \         flagged as a possible mis-assembly"
    inputBinding:
      position: 101
      prefix: --edge_support_threshold
  - id: family_len_dif_percent
    type:
      - 'null'
      - float
    doc: length difference cutoff at the gene family level
    default: 0.0
    inputBinding:
      position: 101
      prefix: --family_len_dif_percent
  - id: family_threshold
    type:
      - 'null'
      - float
    doc: protein family sequence identity threshold
    default: 0.7
    inputBinding:
      position: 101
      prefix: --family_threshold
  - id: high_var_flag
    type:
      - 'null'
      - int
    doc: "minimum number of nested cycles to call a highly\n                     \
      \   variable gene region (default = 5)."
    inputBinding:
      position: 101
      prefix: --high_var_flag
  - id: input_files
    type:
      type: array
      items: File
    doc: "input GFF3 files (usually output from running Prokka).\n               \
      \         Can also take a file listing each gff file line by\n             \
      \           line."
    inputBinding:
      position: 101
      prefix: --input
  - id: len_dif_percent
    type:
      - 'null'
      - float
    doc: length difference cutoff
    default: 0.98
    inputBinding:
      position: 101
      prefix: --len_dif_percent
  - id: length_outlier_support_proportion
    type:
      - 'null'
      - float
    doc: "proportion of genomes supporting a gene with a length\n                \
      \        more than 1.5x outside the interquatile range for\n               \
      \         genes in the same cluster (default=0.01). Genes\n                \
      \        failing this test will be re-annotated at the shorter\n           \
      \             length"
    default: 0.01
    inputBinding:
      position: 101
      prefix: --length_outlier_support_proportion
  - id: merge_paralogs
    type:
      - 'null'
      - boolean
    doc: don't split paralogs
    inputBinding:
      position: 101
      prefix: --merge_paralogs
  - id: min_edge_support_sv
    type:
      - 'null'
      - int
    doc: "minimum edge support required to call structural\n                     \
      \   variants in the presence/absence sv file"
    inputBinding:
      position: 101
      prefix: --min_edge_support_sv
  - id: min_trailing_support
    type:
      - 'null'
      - int
    doc: "minimum cluster size to keep a gene called at the end\n                \
      \        of a contig"
    inputBinding:
      position: 101
      prefix: --min_trailing_support
  - id: no_clean_edges
    type:
      - 'null'
      - boolean
    doc: Turn off edge filtering in the final output graph.
    inputBinding:
      position: 101
      prefix: --no_clean_edges
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: suppress additional output
    inputBinding:
      position: 101
      prefix: --quiet
  - id: refind_mode
    type:
      - 'null'
      - string
    doc: "The stringency mode at which to re-find genes.\n                       \
      \ \n                        default:\n                        Will re-find similar
      gene sequences. Allows for\n                        premature stop codons and
      incorrect lengths to account\n                        for misassemblies.\n \
      \                       \n                        strict:\n                \
      \        Prevents fragmented, misassembled, or potential\n                 \
      \       pseudogene sequences from being re-found.\n                        \n\
      \                        off:\n                        Turns off all re-finding
      steps."
    inputBinding:
      position: 101
      prefix: --refind-mode
  - id: refind_prop_match
    type:
      - 'null'
      - float
    doc: "the proportion of an accessory gene that must be found\n               \
      \         in order to consider it a match"
    inputBinding:
      position: 101
      prefix: --refind_prop_match
  - id: remove_by_consensus
    type:
      - 'null'
      - boolean
    doc: "if a gene is called in the same region with similar\n                  \
      \      sequence a minority of the time, remove it. One of\n                \
      \        'True' or 'False'"
    inputBinding:
      position: 101
      prefix: --remove_by_consensus
  - id: remove_invalid_genes
    type:
      - 'null'
      - boolean
    doc: "removes annotations that do not conform to the\n                       \
      \ expected Prokka format such as those including\n                        premature
      stop codons."
    inputBinding:
      position: 101
      prefix: --remove-invalid-genes
  - id: search_radius
    type:
      - 'null'
      - int
    doc: "the distance in nucleotides surronding the neighbour\n                 \
      \       of an accessory gene in which to search for it"
    inputBinding:
      position: 101
      prefix: --search_radius
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: threshold
    type:
      - 'null'
      - float
    doc: sequence identity threshold
    default: 0.98
    inputBinding:
      position: 101
      prefix: --threshold
  - id: trailing_recursive
    type:
      - 'null'
      - int
    doc: "number of times to perform recursive trimming of low\n                 \
      \       support nodes near the end of contigs"
    inputBinding:
      position: 101
      prefix: --trailing_recursive
outputs:
  - id: output_dir
    type: Directory
    doc: location of an output directory
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/panaroo:1.6.0--pyhdfd78af_0
