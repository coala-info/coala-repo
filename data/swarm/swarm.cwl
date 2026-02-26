cwlVersion: v1.2
class: CommandLineTool
baseCommand: swarm
label: swarm
doc: "Swarm 3.1.6\n\nTool homepage: https://github.com/torognes/swarm"
inputs:
  - id: fasta_file
    type:
      - 'null'
      - File
    doc: Input FASTA file
    inputBinding:
      position: 1
  - id: append_abundance
    type:
      - 'null'
      - int
    doc: value to use when abundance is missing
    inputBinding:
      position: 102
      prefix: --append-abundance
  - id: bloom_bits
    type:
      - 'null'
      - int
    doc: bits used per Bloom filter entry
    default: 16
    inputBinding:
      position: 102
      prefix: --bloom-bits
  - id: boundary
    type:
      - 'null'
      - int
    doc: min mass of large clusters
    default: 3
    inputBinding:
      position: 102
      prefix: --boundary
  - id: ceiling
    type:
      - 'null'
      - int
    doc: max memory in MB for Bloom filter (unlim.)
    inputBinding:
      position: 102
      prefix: --ceiling
  - id: differences
    type:
      - 'null'
      - int
    doc: resolution
    default: 1
    inputBinding:
      position: 102
      prefix: --differences
  - id: disable_sse3
    type:
      - 'null'
      - boolean
    doc: disable SSE3 and later x86 instructions
    inputBinding:
      position: 102
      prefix: --disable-sse3
  - id: fastidious
    type:
      - 'null'
      - boolean
    doc: link nearby low-abundance swarms
    inputBinding:
      position: 102
      prefix: --fastidious
  - id: gap_extension_penalty
    type:
      - 'null'
      - int
    doc: gap extension penalty
    default: 4
    inputBinding:
      position: 102
      prefix: --gap-extension-penalty
  - id: gap_opening_penalty
    type:
      - 'null'
      - int
    doc: gap open penalty
    default: 12
    inputBinding:
      position: 102
      prefix: --gap-opening-penalty
  - id: internal_structure
    type:
      - 'null'
      - File
    doc: write internal cluster structure to file
    inputBinding:
      position: 102
      prefix: --internal-structure
  - id: log_file
    type:
      - 'null'
      - File
    doc: log to file, not to stderr
    inputBinding:
      position: 102
      prefix: --log
  - id: match_reward
    type:
      - 'null'
      - int
    doc: reward for nucleotide match
    default: 5
    inputBinding:
      position: 102
      prefix: --match-reward
  - id: mismatch_penalty
    type:
      - 'null'
      - int
    doc: penalty for nucleotide mismatch
    default: 4
    inputBinding:
      position: 102
      prefix: --mismatch-penalty
  - id: mothur
    type:
      - 'null'
      - boolean
    doc: output using mothur-like format
    inputBinding:
      position: 102
      prefix: --mothur
  - id: network_file
    type:
      - 'null'
      - File
    doc: dump sequence network to file
    inputBinding:
      position: 102
      prefix: --network-file
  - id: no_otu_breaking
    type:
      - 'null'
      - boolean
    doc: never break clusters (not recommended!)
    inputBinding:
      position: 102
      prefix: --no-otu-breaking
  - id: seeds
    type:
      - 'null'
      - File
    doc: write cluster representatives to FASTA file
    inputBinding:
      position: 102
      prefix: --seeds
  - id: statistics_file
    type:
      - 'null'
      - File
    doc: dump cluster statistics to file
    inputBinding:
      position: 102
      prefix: --statistics-file
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
  - id: uclust_file
    type:
      - 'null'
      - File
    doc: output using UCLUST-like format to file
    inputBinding:
      position: 102
      prefix: --uclust-file
  - id: usearch_abundance
    type:
      - 'null'
      - boolean
    doc: abundance annotation in usearch style
    inputBinding:
      position: 102
      prefix: --usearch-abundance
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output result to file (stdout)
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/swarm:3.1.6--h9948957_0
