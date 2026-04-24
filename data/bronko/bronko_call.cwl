cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bronko
  - call
label: bronko_call
doc: "Perform rapid viral variant calling of viral sequencing data\n\nTool homepage:
  https://github.com/treangenlab/bronko"
inputs:
  - id: alignment
    type:
      - 'null'
      - boolean
    doc: Output an multifasta containing the alignment of all samples to the 
      reference and themselves (only major variant positions)
    inputBinding:
      position: 101
      prefix: --alignment
  - id: balance_ratio
    type:
      - 'null'
      - float
    doc: Percent of total depth that one strand must be under to be considered 
      unbalanced (must be [0.0-1.0])
    inputBinding:
      position: 101
      prefix: --balance-ratio
  - id: consensus
    type:
      - 'null'
      - boolean
    doc: Return consensus sequences for each virus (.fasta format)
    inputBinding:
      position: 101
      prefix: --consensus
  - id: db
    type:
      - 'null'
      - File
    doc: Use a prebuilt bronko db (.bkdb) of genomes of interest
    inputBinding:
      position: 101
      prefix: --db
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Debug output
    inputBinding:
      position: 101
      prefix: --debug
  - id: file_input
    type:
      - 'null'
      - File
    doc: Path to .txt file containing paths to each fastq file, one line per 
      file (paired end reads should be tab delimited on same line)
    inputBinding:
      position: 101
      prefix: --file-input
  - id: first_pairs
    type:
      - 'null'
      - type: array
        items: File
    doc: First pairs for raw paired-end reads (fastq/gzip)
    inputBinding:
      position: 101
      prefix: --first-pairs
  - id: genomes
    type:
      - 'null'
      - type: array
        items: File
    doc: Genome fasta(.gz) files to use as references (bronko build will be 
      called)
    inputBinding:
      position: 101
      prefix: --genomes
  - id: keep_kmer_info
    type:
      - 'null'
      - boolean
    doc: Keep kmer count information and temporary files (deleted by default)
    inputBinding:
      position: 101
      prefix: --keep-kmer-info
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: Kmer size used for analysis
    inputBinding:
      position: 101
      prefix: --kmer-size
  - id: min_af
    type:
      - 'null'
      - float
    doc: Minimum minor allele frequency to be reported
    inputBinding:
      position: 101
      prefix: --min-af
  - id: min_depth
    type:
      - 'null'
      - int
    doc: Minimum total depth at an allele to call a minor variant 
      (default=100*min_kmers)
    inputBinding:
      position: 101
      prefix: --min-depth
  - id: min_kmers
    type:
      - 'null'
      - int
    doc: Minimum times a kmer must occur in sequencing data to be used
    inputBinding:
      position: 101
      prefix: --min-kmers
  - id: min_variant_depth
    type:
      - 'null'
      - int
    doc: Minimum depth of a minor variant to be called present 
      (default=min_kmers)
    inputBinding:
      position: 101
      prefix: --min-variant-depth
  - id: n_fixed
    type:
      - 'null'
      - int
    doc: Number of fixed positions at the end of each kmer that cannot 
      contribute to pileup
    inputBinding:
      position: 101
      prefix: --n-fixed
  - id: n_per_strand
    type:
      - 'null'
      - int
    doc: Min number of unique kmers to observe to call a variant at any site 
      (needed on both strands if strand filter active)
    inputBinding:
      position: 101
      prefix: --n-per-strand
  - id: no_end_filter
    type:
      - 'null'
      - boolean
    doc: Do not filter variants from beginning and end k bases of each segment
    inputBinding:
      position: 101
      prefix: --no-end-filter
  - id: no_strand_balance_filter
    type:
      - 'null'
      - boolean
    doc: Allow variants with extreme strand disbalance pass without SOR check 
      (will not matter if --no-strand-filter present)
    inputBinding:
      position: 101
      prefix: --no-strand-balance-filter
  - id: no_strand_filter
    type:
      - 'null'
      - boolean
    doc: Do not utilize SOR test to filter variants that are present on one 
      strand but not the other
    inputBinding:
      position: 101
      prefix: --no-strand-filter
  - id: pileup
    type:
      - 'null'
      - boolean
    doc: Also output a tsv of the approximate pileup for each sample and 
      reference
    inputBinding:
      position: 101
      prefix: --pileup
  - id: reads
    type:
      - 'null'
      - type: array
        items: File
    doc: Input single-end reads (fastq/gzip)
    inputBinding:
      position: 101
      prefix: --reads
  - id: second_pairs
    type:
      - 'null'
      - type: array
        items: File
    doc: Second pairs for raw paired-end reads (fastq/gzip)
    inputBinding:
      position: 101
      prefix: --second-pairs
  - id: strand_odds
    type:
      - 'null'
      - int
    doc: Maximum strand odds ratio for a variant to pass strand filtering
    inputBinding:
      position: 101
      prefix: --strand_odds
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: use_full_kmer
    type:
      - 'null'
      - boolean
    doc: Use the entire kmer length for variant positions rather than having 
      [--n-fixed] bases on each end
    inputBinding:
      position: 101
      prefix: --use-full-kmer
  - id: variant_multiplier
    type:
      - 'null'
      - float
    doc: How much greater (1x, 1.5x, etc) the minor allele frequency of a 
      variant must be above estimated baseline noise in that region (must be > 
      1.0x). Note that for variants under 1%, multiplier will be increased 
      exponentially up to +0.5 more
    inputBinding:
      position: 101
      prefix: --noise-multiplier
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'Verbose output (warning: very verbose)'
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: Folder to output all resulting files
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bronko:0.1.3--h4349ce8_0
