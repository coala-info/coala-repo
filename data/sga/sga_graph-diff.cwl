cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sga
  - graph-diff
label: sga_graph-diff
doc: "Find and report strings only present in the graph of VARIANT when compared to
  BASE\n\nTool homepage: https://github.com/jts/sga"
inputs:
  - id: algorithm
    type:
      - 'null'
      - string
    doc: 'select the assembly algorithm to use from: debruijn, string'
    inputBinding:
      position: 101
      prefix: --algorithm
  - id: base_file
    type: File
    doc: "use the read set in FILE as the base line for comparison\n             \
      \                          if this option is not given, reference-based calls
      will be made"
    inputBinding:
      position: 101
      prefix: --base
  - id: genome_size
    type:
      - 'null'
      - int
    doc: "set the size of the genome to be N bases\n                             \
      \          this is used to determine the number of bits to use in the bloom
      filter\n                                       if unset, it will be calculated
      from the reference genome FASTA file"
    inputBinding:
      position: 101
      prefix: --genome-size
  - id: kmer
    type:
      - 'null'
      - int
    doc: use K-mers to discover variants
    inputBinding:
      position: 101
      prefix: --kmer
  - id: min_dbg_count
    type:
      - 'null'
      - int
    doc: only use k-mers seen T times when assembling using a de Bruijn graph
    inputBinding:
      position: 101
      prefix: --min-dbg-count
  - id: min_discovery_count
    type:
      - 'null'
      - int
    doc: require a variant k-mer to be seen at least T times
    inputBinding:
      position: 101
      prefix: --min-discovery-count
  - id: min_overlap
    type:
      - 'null'
      - int
    doc: require at least N bp overlap when assembling using a string graph
    inputBinding:
      position: 101
      prefix: --min-overlap
  - id: precache_reference
    type:
      - 'null'
      - string
    doc: "precache the named chromosome of the reference genome\n                \
      \                       If STR is \"all\" the entire reference will be cached"
    inputBinding:
      position: 101
      prefix: --precache-reference
  - id: prefix
    type:
      - 'null'
      - string
    doc: prefix the output files with NAME
    inputBinding:
      position: 101
      prefix: --prefix
  - id: reference_file
    type: File
    doc: use the reference sequence in FILE
    inputBinding:
      position: 101
      prefix: --reference
  - id: threads
    type:
      - 'null'
      - int
    doc: use NUM computation threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: variant_file
    type: File
    doc: call variants present in the read set in FILE
    inputBinding:
      position: 101
      prefix: --variant
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: display verbose output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sga:v0.10.15-4-deb_cv1
stdout: sga_graph-diff.out
