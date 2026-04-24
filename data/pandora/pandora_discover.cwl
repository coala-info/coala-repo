cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - /usr/local/bin/pandora
  - discover
label: pandora_discover
doc: "Quasi-map reads to an indexed PRG, infer the sequence of present loci in the
  sample and discover novel variants.\n\nTool homepage: https://github.com/rmcolq/pandora"
inputs:
  - id: target
    type: File
    doc: An indexed PRG file (in fasta format)
    inputBinding:
      position: 1
  - id: query_idx
    type: File
    doc: A tab-delimited file where each line is a sample identifier followed by the
      path to the fast{a,q} of reads for that sample
    inputBinding:
      position: 2
  - id: binomial_model
    type:
      - 'null'
      - boolean
    doc: 'Use binomial model for kmer coverages [default: negative binomial]'
    inputBinding:
      position: 103
      prefix: --bin
  - id: clean
    type:
      - 'null'
      - boolean
    doc: Add a step to clean and detangle the pangraph
    inputBinding:
      position: 103
      prefix: --clean
  - id: clean_dbg
    type:
      - 'null'
      - boolean
    doc: Clean the local assembly de Bruijn graph
    inputBinding:
      position: 103
      prefix: --clean-dbg
  - id: covg_threshold
    type:
      - 'null'
      - int
    doc: Positions with coverage less than this will be tagged for variant discovery
    inputBinding:
      position: 103
      prefix: --covg-threshold
  - id: discover_k
    type:
      - 'null'
      - int
    doc: K-mer size to use when discovering novel variants
    inputBinding:
      position: 103
      prefix: --discover-k
  - id: error_rate
    type:
      - 'null'
      - float
    doc: Estimated error rate for reads
    inputBinding:
      position: 103
      prefix: --error-rate
  - id: genome_size
    type:
      - 'null'
      - string
    doc: Estimated length of the genome - used for coverage estimation. Can pass string
      such as 4.4m, 100k etc.
    inputBinding:
      position: 103
      prefix: --genome-size
  - id: illumina
    type:
      - 'null'
      - boolean
    doc: Reads are from Illumina. Alters error rate used and adjusts for shorter reads
    inputBinding:
      position: 103
      prefix: --illumina
  - id: kmer_avg
    type:
      - 'null'
      - int
    doc: Maximum number of kmers to average over when selecting the maximum likelihood
      path
    inputBinding:
      position: 103
      prefix: --kmer-avg
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: K-mer size for (w,k)-minimizers
    inputBinding:
      position: 103
      prefix: -k
  - id: mapped_reads
    type:
      - 'null'
      - boolean
    doc: Save a fasta file for each loci containing read parts which overlapped it
    inputBinding:
      position: 103
      prefix: --mapped-reads
  - id: max_candidate_variants
    type:
      - 'null'
      - int
    doc: Maximum number of candidate variants allowed for a candidate region
    inputBinding:
      position: 103
      prefix: -N
  - id: max_covg
    type:
      - 'null'
      - int
    doc: Maximum coverage of reads to accept
    inputBinding:
      position: 103
      prefix: --max-covg
  - id: max_diff
    type:
      - 'null'
      - int
    doc: Maximum distance (bp) between consecutive hits within a cluster
    inputBinding:
      position: 103
      prefix: --max-diff
  - id: max_ins
    type:
      - 'null'
      - int
    doc: 'Max. insertion size for novel variants. Warning: setting too long may impair
      performance'
    inputBinding:
      position: 103
      prefix: --max-ins
  - id: max_length_consecutive
    type:
      - 'null'
      - int
    doc: Max. length of consecutive positions below coverage threshold to trigger
      variant discovery
    inputBinding:
      position: 103
      prefix: -L
  - id: merge
    type:
      - 'null'
      - int
    doc: Merge candidate variant intervals within distance
    inputBinding:
      position: 103
      prefix: --merge
  - id: min_cluster_size
    type:
      - 'null'
      - int
    doc: Minimum size of a cluster of hits between a read and a loci to consider the
      loci present
    inputBinding:
      position: 103
      prefix: --min-cluster-size
  - id: min_dbg_dp
    type:
      - 'null'
      - int
    doc: Minimum node/kmer depth in the de Bruijn graph used for discovering variants
    inputBinding:
      position: 103
      prefix: --min-dbg-dp
  - id: min_length_consecutive
    type:
      - 'null'
      - int
    doc: Min. length of consecutive positions below coverage threshold to trigger
      variant discovery
    inputBinding:
      position: 103
      prefix: -l
  - id: save_kmer_graphs
    type:
      - 'null'
      - boolean
    doc: Save kmer graphs with forward and reverse coverage annotations for found
      loci
    inputBinding:
      position: 103
      prefix: --kg
  - id: threads
    type:
      - 'null'
      - int
    doc: Maximum number of threads to use
    inputBinding:
      position: 103
      prefix: --threads
  - id: verbosity
    type:
      - 'null'
      - type: array
        items: boolean
    doc: Verbosity of logging. Repeat for increased verbosity
    inputBinding:
      position: 103
      prefix: -v
  - id: window_size
    type:
      - 'null'
      - int
    doc: Window size for (w,k)-minimizers (must be <=k)
    inputBinding:
      position: 103
      prefix: -w
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Directory to write output files to
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pandora:0.9.2--h4ac6f70_0
