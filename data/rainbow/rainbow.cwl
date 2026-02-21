cwlVersion: v1.2
class: CommandLineTool
baseCommand: rainbow
label: rainbow
doc: "Rainbow is a tool for clustering and assembling short reads, specifically designed
  for RAD-seq data. It includes subcommands for clustering, dividing clusters into
  haplotypes, and merging clusters.\n\nTool homepage: https://github.com/SaekiRaku/vscode-rainbow-fart"
inputs:
  - id: subcommand
    type: string
    doc: The subcommand to execute (cluster, div, or merge)
    inputBinding:
      position: 1
  - id: input_file
    type:
      - 'null'
      - File
    doc: 'Input file (default: stdin)'
    inputBinding:
      position: 102
      prefix: -i
  - id: kmer_clustering
    type:
      - 'null'
      - int
    doc: K-mer length for clustering
    default: 10
    inputBinding:
      position: 102
      prefix: -K
  - id: kmer_seed
    type:
      - 'null'
      - int
    doc: K-mer length for seed
    default: 4
    inputBinding:
      position: 102
      prefix: -k
  - id: max_clones
    type:
      - 'null'
      - int
    doc: Maximum number of clones
    default: 1000
    inputBinding:
      position: 102
      prefix: -M
  - id: max_mismatch_fraction
    type:
      - 'null'
      - float
    doc: Maximum fraction of mismatches
    default: 0.2
    inputBinding:
      position: 102
      prefix: -f
  - id: min_clones
    type:
      - 'null'
      - int
    doc: Minimum number of clones
    default: 2
    inputBinding:
      position: 102
      prefix: -m
  - id: min_reads
    type:
      - 'null'
      - int
    doc: Minimum number of reads to form a cluster
    default: 5
    inputBinding:
      position: 102
      prefix: -r
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: 'Output file (default: stdout)'
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rainbow:2.0.4--pl5321h7b50bb2_11
