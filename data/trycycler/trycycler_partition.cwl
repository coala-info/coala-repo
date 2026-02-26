cwlVersion: v1.2
class: CommandLineTool
baseCommand: trycycler partition
label: trycycler_partition
doc: "partition reads by cluster\n\nTool homepage: https://github.com/rrwick/Trycycler"
inputs:
  - id: cluster_dirs
    type:
      type: array
      items: Directory
    doc: "Cluster directories (each should contain\n                          2_all_seqs.fasta
      and 3_pairwise_alignments files)"
    inputBinding:
      position: 101
      prefix: --cluster_dirs
  - id: min_aligned_len
    type:
      - 'null'
      - int
    doc: "Do not consider reads with less than this many bases\n                 \
      \         aligned"
    default: 1000
    inputBinding:
      position: 101
      prefix: --min_aligned_len
  - id: min_read_cov
    type:
      - 'null'
      - float
    doc: "Do not consider reads with less than this\n                          percentages
      of their length covered by alignments"
    default: 90.0
    inputBinding:
      position: 101
      prefix: --min_read_cov
  - id: reads
    type: File
    doc: "Long reads (FASTQ format) used to generate the\n                       \
      \   assemblies"
    inputBinding:
      position: 101
      prefix: --reads
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for alignment
    default: 16
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/trycycler:0.5.6--pyhdfd78af_0
stdout: trycycler_partition.out
