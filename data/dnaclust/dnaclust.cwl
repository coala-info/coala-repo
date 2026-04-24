cwlVersion: v1.2
class: CommandLineTool
baseCommand: dnaclust
label: dnaclust
doc: "The output is written to STDOUT. Each line will contain the ids of the sequences
  in each cluster, and the first id of each line is the cluster representative.\n\n\
  Tool homepage: https://github.com/jenhantao/DNACluster"
inputs:
  - id: fasta_file
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 1
  - id: approximate_filter
    type:
      - 'null'
      - boolean
    doc: use faster approximate k-mer filter
    inputBinding:
      position: 102
      prefix: --approximate-filter
  - id: assign_ambiguous
    type:
      - 'null'
      - boolean
    doc: assign ambiguous reads to clusters based on abundances of non-ambiguous
      reads
    inputBinding:
      position: 102
      prefix: --assign-ambiguous
  - id: header
    type:
      - 'null'
      - boolean
    doc: output header line indicating run options
    inputBinding:
      position: 102
      prefix: --header
  - id: input_file
    type:
      - 'null'
      - File
    doc: input file
    inputBinding:
      position: 102
      prefix: --input-file
  - id: k_mer_filter
    type:
      - 'null'
      - boolean
    doc: use k-mer filter
    inputBinding:
      position: 102
      prefix: --k-mer-filter
  - id: k_mer_length
    type:
      - 'null'
      - int
    doc: length of k-mer for filtering
    inputBinding:
      position: 102
      prefix: --k-mer-length
  - id: left_gaps_allowed
    type:
      - 'null'
      - boolean
    doc: allow for gaps on the left of shorter string in semi-global alignment
    inputBinding:
      position: 102
      prefix: --left-gaps-allowed
  - id: mismatches
    type:
      - 'null'
      - int
    doc: number of mismatches allowed from cluster center
    inputBinding:
      position: 102
      prefix: --mismatches
  - id: no_k_mer_filter
    type:
      - 'null'
      - boolean
    doc: do not use k-mer filter
    inputBinding:
      position: 102
      prefix: --no-k-mer-filter
  - id: no_overlap
    type:
      - 'null'
      - boolean
    doc: cluster some of sequences such that the cluster centers are at distance
      at least two times the radius of the clusters
    inputBinding:
      position: 102
      prefix: --no-overlap
  - id: predetermined_cluster_centers
    type:
      - 'null'
      - File
    doc: file containing predetermined cluster centers
    inputBinding:
      position: 102
      prefix: --predetermined-cluster-centers
  - id: print_inverted_index
    type:
      - 'null'
      - boolean
    doc: Print mapping from sequence to each center
    inputBinding:
      position: 102
      prefix: --print-inverted-index
  - id: random_seed
    type:
      - 'null'
      - int
    doc: Seed for random number generator
    inputBinding:
      position: 102
      prefix: --random-seed
  - id: recruit_only
    type:
      - 'null'
      - boolean
    doc: when used with 'predetermined-cluster-centers' option, only clusters 
      the input sequences that are similar to the predetermined centers
    inputBinding:
      position: 102
      prefix: --recruit-only
  - id: similarity
    type:
      - 'null'
      - float
    doc: set similarity between cluster center and cluster sequences
    inputBinding:
      position: 102
      prefix: --similarity
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 102
      prefix: --threads
  - id: use_full_query_header
    type:
      - 'null'
      - boolean
    doc: use the full query header instead of the first word
    inputBinding:
      position: 102
      prefix: --use-full-query-header
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/dnaclust:v3-4b2-deb_cv1
stdout: dnaclust.out
