cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tracs
  - pipe
label: tracs_pipe
doc: "A script to run the full TRACS pipeline.\n\nTool homepage: https://github.com/gtonkinhill/tracs"
inputs:
  - id: clock_rate
    type:
      - 'null'
      - float
    doc: "clock rate as defined in the transcluster paper\n                      \
      \  (SNPs/genome/year)"
    default: 1e-3 * 29903
    inputBinding:
      position: 101
      prefix: --clock_rate
  - id: cluster_distance
    type:
      - 'null'
      - string
    doc: "The type of transmission distance to use. Can be one\n                 \
      \       of 'snp' (default), 'filter', 'direct', 'expectedK'"
    default: snp
    inputBinding:
      position: 101
      prefix: --cluster_distance
  - id: cluster_threshold
    type:
      - 'null'
      - int
    doc: "Distance threshold. Samples will be grouped together\n                 \
      \       if the distance between them is below this threshold."
    default: 10
    inputBinding:
      position: 101
      prefix: --cluster_threshold
  - id: consensus
    type:
      - 'null'
      - boolean
    doc: "Turns on consensus mode. Only the most common allele\n                 \
      \       at each site will be reported and all other filters\n              \
      \          will be ignored."
    inputBinding:
      position: 101
      prefix: --consensus
  - id: database
    type: string
    doc: path to database signatures
    inputBinding:
      position: 101
      prefix: --database
  - id: either_strand
    type:
      - 'null'
      - boolean
    doc: "turns off the requirement that a variant is supported\n                \
      \        by both strands"
    inputBinding:
      position: 101
      prefix: --either-strand
  - id: error_threshold
    type:
      - 'null'
      - float
    doc: "Threshold to exclude likely erroneous variants prior\n                 \
      \       to fitting Dirichlet multinomial model"
    inputBinding:
      position: 101
      prefix: --error-perc
  - id: filter_snp_regions
    type:
      - 'null'
      - boolean
    doc: "Filter out regions with unusually high SNP distances\n                 \
      \       often caused by HGT"
    inputBinding:
      position: 101
      prefix: --filter
  - id: input_file
    type: File
    doc: path to text file containing input file paths
    inputBinding:
      position: 101
      prefix: --input
  - id: keep_all
    type:
      - 'null'
      - boolean
    doc: "turns on filtering of variants with support below the\n                \
      \        posterior frequency threshold"
    inputBinding:
      position: 101
      prefix: --keep-all
  - id: keep_cov_outliers
    type:
      - 'null'
      - boolean
    doc: "Turns off filtering of genome regions with unusual\n                   \
      \     coverage. Useful if no gene gain/loss is expected."
    inputBinding:
      position: 101
      prefix: --keep-cov-outliers
  - id: loglevel
    type:
      - 'null'
      - string
    doc: Set the logging threshold.
    inputBinding:
      position: 101
      prefix: --loglevel
  - id: max_div
    type:
      - 'null'
      - float
    doc: ignore queries with per-base divergence > max_div
    default: 1
    inputBinding:
      position: 101
      prefix: --max_div
  - id: metadata
    type:
      - 'null'
      - File
    doc: "Location of metadata in csv format. The first column\n                 \
      \       must include the sequence names and the second column\n            \
      \            must include sampling dates."
    inputBinding:
      position: 101
      prefix: --meta
  - id: min_base_qual
    type:
      - 'null'
      - int
    doc: minimum base quality
    default: 0
    inputBinding:
      position: 101
      prefix: --min_base_qual
  - id: min_cov
    type:
      - 'null'
      - int
    doc: Minimum read coverage
    default: 5
    inputBinding:
      position: 101
      prefix: --min-cov
  - id: min_map_qual
    type:
      - 'null'
      - int
    doc: minimum mapping quality
    default: 0
    inputBinding:
      position: 101
      prefix: --min_map_qual
  - id: min_query_len
    type:
      - 'null'
      - int
    doc: minimum query length
    default: 0
    inputBinding:
      position: 101
      prefix: --min_query_len
  - id: minimap_preset
    type:
      - 'null'
      - string
    doc: "minimap preset to use - one of 'sr' (default), 'map-\n                 \
      \       ont' or 'map-pb'"
    inputBinding:
      position: 101
      prefix: --minimap_preset
  - id: precision
    type:
      - 'null'
      - float
    doc: The precision used to calculate E(K)
    default: 0.01
    inputBinding:
      position: 101
      prefix: --precision
  - id: refseqs
    type:
      - 'null'
      - File
    doc: path to reference fasta files
    inputBinding:
      position: 101
      prefix: --refseqs
  - id: snp_threshold
    type:
      - 'null'
      - int
    doc: "Only output those transmission pairs with a SNP\n                      \
      \  distance <= D"
    inputBinding:
      position: 101
      prefix: --snp_threshold
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: trans_rate
    type:
      - 'null'
      - int
    doc: "transmission rate as defined in the transcluster paper\n               \
      \         (transmissions/year)"
    default: 73
    inputBinding:
      position: 101
      prefix: --trans_rate
  - id: trans_threshold
    type:
      - 'null'
      - int
    doc: "Only outputs those pairs where the most likely number\n                \
      \        of intermediate hosts <= K"
    inputBinding:
      position: 101
      prefix: --trans_threshold
  - id: trim
    type:
      - 'null'
      - int
    doc: ignore bases within TRIM-bp from either end of a read
    default: 0
    inputBinding:
      position: 101
      prefix: --trim
outputs:
  - id: output_dir
    type: Directory
    doc: location of an output directory
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tracs:1.0.1--py312h43eeafb_1
