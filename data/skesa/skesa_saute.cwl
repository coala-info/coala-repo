cwlVersion: v1.2
class: CommandLineTool
baseCommand: saute
label: skesa_saute
doc: "Assemble reads along reference target sequences and write a GFA graph of variants\n\nTool homepage: https://github.com/ncbi/SKESA"
inputs:
  - id: cores
    type:
      - 'null'
      - int
    doc: 'Number of cores to use (default all) [default: 0]'
    inputBinding:
      position: 101
      prefix: --cores
  - id: estimated_kmers
    type:
      - 'null'
      - int
    doc: 'Estimated number of distinct kmers for bloom filter (millions) [default: 1000]'
    inputBinding:
      position: 101
      prefix: --estimated_kmers
  - id: gfa_path
    type:
      - 'null'
      - string
    doc: 'Output file for GFA graph'
    inputBinding:
      position: 102
      prefix: --gfa
  - id: all_variants_path
    type:
      - 'null'
      - string
    doc: 'Output file for sequences with all variant combinations'
    inputBinding:
      position: 102
      prefix: --all_variants
  - id: max_variants
    type:
      - 'null'
      - int
    doc: 'Restricts the number of variants outputted in --all_variants [default: 1000]'
    inputBinding:
      position: 101
      prefix: --max_variants
  - id: selected_variants_path
    type:
      - 'null'
      - string
    doc: 'Output file for selected sequences representing all graph elements'
    inputBinding:
      position: 102
      prefix: --selected_variants
  - id: targets
    type:
      - 'null'
      - File
    doc: 'Input file with reference sequences'
    inputBinding:
      position: 101
      prefix: --targets
  - id: reads
    type:
      - 'null'
      - type: array
        items: File
    doc: 'Input fasta/fastq file(s) for reads, could be gzipped. Files are joined with commas into one --reads value (use two files for a read pair).'
    inputBinding:
      position: 101
      prefix: --reads
      itemSeparator: ','
  - id: use_paired_ends
    type:
      - 'null'
      - boolean
    doc: 'Indicates that single (not comma separated) fasta/fastq files contain paired reads'
    inputBinding:
      position: 101
      prefix: --use_paired_ends
  - id: extend_ends
    type:
      - 'null'
      - boolean
    doc: 'Unambiguously extend graph ends using de-novo assembly'
    inputBinding:
      position: 101
      prefix: --extend_ends
  - id: kmer
    type:
      - 'null'
      - int
    doc: 'Kmer length for assembly (default automatic)'
    inputBinding:
      position: 101
      prefix: --kmer
  - id: secondary_kmer
    type:
      - 'null'
      - int
    doc: 'Shorter kmer length for low coverage spots (default automatic)'
    inputBinding:
      position: 101
      prefix: --secondary_kmer
  - id: secondary_kmer_threshold
    type:
      - 'null'
      - int
    doc: 'Coverage threshold for using shorter kmer [default: 1]'
    inputBinding:
      position: 101
      prefix: --secondary_kmer_threshold
  - id: min_count
    type:
      - 'null'
      - int
    doc: 'Minimal count for kmers retained in graph [default: 2]'
    inputBinding:
      position: 101
      prefix: --min_count
  - id: vector_percent
    type:
      - 'null'
      - float
    doc: 'Percentage of reads containing 19-mer for the 19-mer to be considered a vector (1. disables) [float (0,1]] [default: 0.05]'
    inputBinding:
      position: 101
      prefix: --vector_percent
  - id: fraction
    type:
      - 'null'
      - float
    doc: 'Maximum noise to signal ratio acceptable for extension [default: 0.05]'
    inputBinding:
      position: 101
      prefix: --fraction
  - id: word
    type:
      - 'null'
      - int
    doc: 'Word size for seeds [default: 8]'
    inputBinding:
      position: 101
      prefix: --word
  - id: protect_reference_ends
    type:
      - 'null'
      - boolean
    doc: 'Near the reference ends, don''t check if reads support some minimal extension of the fork''s branches'
    inputBinding:
      position: 101
      prefix: --protect_reference_ends
  - id: keep_subgraphs
    type:
      - 'null'
      - boolean
    doc: 'Don''t remove redundant subgraphs'
    inputBinding:
      position: 101
      prefix: --keep_subgraphs
  - id: match
    type:
      - 'null'
      - int
    doc: 'Bonus for match [default: 2]'
    inputBinding:
      position: 101
      prefix: --match
  - id: mismatch
    type:
      - 'null'
      - int
    doc: 'Penalty for mismatch [default: 3]'
    inputBinding:
      position: 101
      prefix: --mismatch
  - id: gap_open
    type:
      - 'null'
      - int
    doc: 'Penalty for gap opening [default: 5]'
    inputBinding:
      position: 101
      prefix: --gap_open
  - id: gap_extend
    type:
      - 'null'
      - int
    doc: 'Penalty for gap extension [default: 3]'
    inputBinding:
      position: 101
      prefix: --gap_extend
  - id: drop_off
    type:
      - 'null'
      - int
    doc: 'Maximal decrease of score before abandoning assembly path [default: 300]'
    inputBinding:
      position: 101
      prefix: --drop_off
  - id: kmer_complexity
    type:
      - 'null'
      - int
    doc: 'Hard mask reference areas with hight kmer complexity (0 disables masking) [default: 2000]'
    inputBinding:
      position: 101
      prefix: --kmer_complexity
  - id: max_fork_density
    type:
      - 'null'
      - float
    doc: 'Maximal fork density averaged over --buf_length before abandoning assembling (0 disables) [default: 0.1]'
    inputBinding:
      position: 101
      prefix: --max_fork_density
  - id: buf_length
    type:
      - 'null'
      - int
    doc: 'Buffer length for fork density [default: 200]'
    inputBinding:
      position: 101
      prefix: --buf_length
  - id: not_aligned_len
    type:
      - 'null'
      - int
    doc: 'Not aligned read length for break count [default: 10]'
    inputBinding:
      position: 101
      prefix: --not_aligned_len
  - id: not_aligned_count
    type:
      - 'null'
      - int
    doc: 'Number of not aligned reads to make a break [default: 3]'
    inputBinding:
      position: 101
      prefix: --not_aligned_count
  - id: aligned_count
    type:
      - 'null'
      - int
    doc: 'Number of aligned reads to confirm a connection [default: 2]'
    inputBinding:
      position: 101
      prefix: --aligned_count
  - id: target_coverage
    type:
      - 'null'
      - float
    doc: 'Result is kept if has alignment to the reference which is at least target_coverage*(reference length) long [float (0,1]] [default: 0.5]'
    inputBinding:
      position: 101
      prefix: --target_coverage
  - id: min_hit_len
    type:
      - 'null'
      - int
    doc: 'If a path is shorter than target_coverage*(reference length), use this length threshold for keeping paths (optional)'
    inputBinding:
      position: 101
      prefix: --min_hit_len
  - id: max_path
    type:
      - 'null'
      - int
    doc: 'Maximal number of path extensions allowed for a single filtering check [default: 1000]'
    inputBinding:
      position: 101
      prefix: --max_path
  - id: no_filter_by_reads
    type:
      - 'null'
      - boolean
    doc: 'Don''t use full length reads for variants filtering'
    inputBinding:
      position: 101
      prefix: --no_filter_by_reads
  - id: no_filter_by_pairs
    type:
      - 'null'
      - boolean
    doc: 'Don''t use mate pairs for variants filtering'
    inputBinding:
      position: 101
      prefix: --no_filter_by_pairs
  - id: remove_homopolymer_indels
    type:
      - 'null'
      - boolean
    doc: 'Remove homopolymer indels'
    inputBinding:
      position: 101
      prefix: --remove_homopolymer_indels
  - id: homopolymer_len
    type:
      - 'null'
      - int
    doc: 'Minimal length of homopolymer [default: 4]'
    inputBinding:
      position: 101
      prefix: --homopolymer_len
  - id: homopolymer_ratio
    type:
      - 'null'
      - float
    doc: 'Coverage ratio threshold for removing homopolymer indels [default: 0.33]'
    inputBinding:
      position: 101
      prefix: --homopolymer_ratio
  - id: use_ambiguous_na
    type:
      - 'null'
      - boolean
    doc: 'Use ambiguous nucleotide codes for SNPs'
    inputBinding:
      position: 101
      prefix: --use_ambiguous_na
outputs:
  - id: gfa
    type:
      - 'null'
      - File
    doc: 'Output file for GFA graph'
    outputBinding:
      glob: $(inputs.gfa_path)
  - id: all_variants
    type:
      - 'null'
      - File
    doc: 'Output file for sequences with all variant combinations'
    outputBinding:
      glob: $(inputs.all_variants_path)
  - id: selected_variants
    type:
      - 'null'
      - File
    doc: 'Output file for selected sequences representing all graph elements'
    outputBinding:
      glob: $(inputs.selected_variants_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/skesa:2.5.1--h077b44d_3
