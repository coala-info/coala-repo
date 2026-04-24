cwlVersion: v1.2
class: CommandLineTool
baseCommand: trycycler_consensus
label: trycycler_consensus
doc: "derive a consensus sequence\n\nTool homepage: https://github.com/rrwick/Trycycler"
inputs:
  - id: cluster_dir
    type: Directory
    doc: "Cluster directory (should contain 2_all_seqs.fasta,\n                  \
      \        3_pairwise_alignments and 4_reads.fastq files)"
    inputBinding:
      position: 101
      prefix: --cluster_dir
  - id: linear
    type:
      - 'null'
      - boolean
    doc: "The input contigs are not circular (default: assume\n                  \
      \        the input contigs are circular)"
    inputBinding:
      position: 101
      prefix: --linear
  - id: min_aligned_len
    type:
      - 'null'
      - int
    doc: "Do not consider reads with less than this many bases\n                 \
      \         aligned"
    inputBinding:
      position: 101
      prefix: --min_aligned_len
  - id: min_read_cov
    type:
      - 'null'
      - float
    doc: "Do not consider reads with less than this\n                          percentages
      of their length covered by alignments"
    inputBinding:
      position: 101
      prefix: --min_read_cov
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for alignment
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Display extra output (for debugging)
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/trycycler:0.5.6--pyhdfd78af_0
stdout: trycycler_consensus.out
