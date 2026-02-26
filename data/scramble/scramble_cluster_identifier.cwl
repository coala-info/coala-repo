cwlVersion: v1.2
class: CommandLineTool
baseCommand: cluster_identifier
label: scramble_cluster_identifier
doc: "Identify clusters in BAM/CRAM files based on soft-clipped bases and reads.\n\
  \nTool homepage: https://github.com/GeneDx/scramble"
inputs:
  - id: input_file
    type: File
    doc: Input CRAM or BAM file.
    inputBinding:
      position: 1
  - id: min_soft_clipped_bases
    type:
      - 'null'
      - int
    doc: Minimum number of soft-clipped bases to consider for a cluster.
    inputBinding:
      position: 102
      prefix: -m
  - id: min_soft_clipped_reads
    type:
      - 'null'
      - int
    doc: Minimum number of soft-clipped reads to consider for a cluster.
    inputBinding:
      position: 102
      prefix: -s
  - id: region
    type:
      - 'null'
      - string
    doc: Specific region to analyze (e.g., chr1:1000-2000).
    inputBinding:
      position: 102
      prefix: -r
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scramble:1.0.2--h031d066_1
stdout: scramble_cluster_identifier.out
