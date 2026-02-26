cwlVersion: v1.2
class: CommandLineTool
baseCommand: trycycler cluster
label: trycycler_cluster
doc: "cluster contigs by similarity\n\nTool homepage: https://github.com/rrwick/Trycycler"
inputs:
  - id: assemblies
    type:
      type: array
      items: File
    doc: "Input assemblies whose contigs will be clustered\n                     \
      \     (multiple FASTA files)"
    inputBinding:
      position: 101
      prefix: --assemblies
  - id: distance
    type:
      - 'null'
      - float
    doc: Mash distance complete-linkage clustering threshold
    default: 0.01
    inputBinding:
      position: 101
      prefix: --distance
  - id: min_contig_depth
    type:
      - 'null'
      - float
    doc: "Exclude contigs with less than this much read depth\n                  \
      \        relative to the mean read depth"
    default: 0.1
    inputBinding:
      position: 101
      prefix: --min_contig_depth
  - id: min_contig_len
    type:
      - 'null'
      - int
    doc: "Exclude contigs shorter than this many base pairs in\n                 \
      \         length"
    default: 1000
    inputBinding:
      position: 101
      prefix: --min_contig_len
  - id: out_dir
    type: Directory
    doc: Output directory
    inputBinding:
      position: 101
      prefix: --out_dir
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
stdout: trycycler_cluster.out
