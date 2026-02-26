cwlVersion: v1.2
class: CommandLineTool
baseCommand: skesa
label: skesa
doc: "SKESA (SK-EL-SA) is a de novo assembler for bacterial genomes.\n\nTool homepage:
  https://ftp.ncbi.nlm.nih.gov/pub/agarwala/skesa"
inputs:
  - id: all
    type:
      - 'null'
      - string
    doc: Output fasta for each iteration
    inputBinding:
      position: 101
      prefix: --all
  - id: allow_snps
    type:
      - 'null'
      - boolean
    doc: Allow additional step for snp discovery
    inputBinding:
      position: 101
      prefix: --allow_snps
  - id: cores
    type:
      - 'null'
      - int
    doc: Number of cores to use (default all)
    default: 0
    inputBinding:
      position: 101
      prefix: --cores
  - id: estimated_kmers
    type:
      - 'null'
      - int
    doc: Estimated number of distinct kmers for bloom filter (millions, only for
      hash counter)
    default: 100
    inputBinding:
      position: 101
      prefix: --estimated_kmers
  - id: force_single_ends
    type:
      - 'null'
      - boolean
    doc: Don't use paired-end information
    inputBinding:
      position: 101
      prefix: --force_single_ends
  - id: fraction
    type:
      - 'null'
      - float
    doc: Maximum noise to signal ratio acceptable for extension
    default: 0.1
    inputBinding:
      position: 101
      prefix: --fraction
  - id: hash_count
    type:
      - 'null'
      - boolean
    doc: Use hash counter
    inputBinding:
      position: 101
      prefix: --hash_count
  - id: insert_size
    type:
      - 'null'
      - int
    doc: Expected insert size for paired reads (if not provided, it will be 
      estimated)
    inputBinding:
      position: 101
      prefix: --insert_size
  - id: kmer
    type:
      - 'null'
      - int
    doc: Minimal kmer length for assembly
    default: 21
    inputBinding:
      position: 101
      prefix: --kmer
  - id: max_kmer
    type:
      - 'null'
      - int
    doc: Maximal kmer length for assembly
    inputBinding:
      position: 101
      prefix: --max_kmer
  - id: max_kmer_count
    type:
      - 'null'
      - int
    doc: Minimum acceptable average count for estimating the maximal kmer length
      in reads
    inputBinding:
      position: 101
      prefix: --max_kmer_count
  - id: max_snp_len
    type:
      - 'null'
      - int
    doc: Maximal snp length
    default: 150
    inputBinding:
      position: 101
      prefix: --max_snp_len
  - id: memory
    type:
      - 'null'
      - int
    doc: Memory available (GB, only for sorted counter)
    default: 32
    inputBinding:
      position: 101
      prefix: --memory
  - id: min_contig
    type:
      - 'null'
      - int
    doc: Minimal contig length reported in output
    default: 200
    inputBinding:
      position: 101
      prefix: --min_contig
  - id: min_count
    type:
      - 'null'
      - int
    doc: Minimal count for kmers retained for comparing alternate choices
    inputBinding:
      position: 101
      prefix: --min_count
  - id: reads
    type:
      - 'null'
      - type: array
        items: string
    doc: Input fasta/fastq file(s) for reads (could be used multiple times for 
      different runs, could be gzipped)
    inputBinding:
      position: 101
      prefix: --reads
  - id: seeds
    type:
      - 'null'
      - string
    doc: Input file with seeds
    inputBinding:
      position: 101
      prefix: --seeds
  - id: skip_bloom_filter
    type:
      - 'null'
      - boolean
    doc: Don't do bloom filter; use --estimated_kmers as the hash table size 
      (only for hash counter)
    inputBinding:
      position: 101
      prefix: --skip_bloom_filter
  - id: steps
    type:
      - 'null'
      - int
    doc: Number of assembly iterations from minimal to maximal kmer length in 
      reads
    default: 11
    inputBinding:
      position: 101
      prefix: --steps
  - id: use_paired_ends
    type:
      - 'null'
      - boolean
    doc: Indicates that single (not comma separated) fasta/fastq files contain 
      paired reads
    inputBinding:
      position: 101
      prefix: --use_paired_ends
  - id: vector_percent
    type:
      - 'null'
      - float
    doc: Percentage of reads containing 19-mer for the 19-mer to be considered a
      vector (1. disables)
    default: 0.05
    inputBinding:
      position: 101
      prefix: --vector_percent
outputs:
  - id: contigs_out
    type:
      - 'null'
      - File
    doc: Output file for contigs (stdout if not specified)
    outputBinding:
      glob: $(inputs.contigs_out)
  - id: dbg_out
    type:
      - 'null'
      - File
    doc: Output kmer file
    outputBinding:
      glob: $(inputs.dbg_out)
  - id: hist
    type:
      - 'null'
      - File
    doc: File for histogram
    outputBinding:
      glob: $(inputs.hist)
  - id: connected_reads
    type:
      - 'null'
      - File
    doc: File for connected paired reads
    outputBinding:
      glob: $(inputs.connected_reads)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/skesa:2.5.1--h077b44d_3
