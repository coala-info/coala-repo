cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rainbow
  - cluster
label: rainbow_cluster
doc: "Clusters paired RAD-seq reads; writes seqid, cluster id, read1 and read2 to\
  \ standard output.\n\nTool homepage: https://sourceforge.net/projects/bio-rainbow/"
inputs:
  - id: read1
    type:
      type: array
      items: File
      inputBinding:
        prefix: '-1'
    doc: Input fasta/fastq file, supports multiple '-1'
    inputBinding:
      position: 101
  - id: read2
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: '-2'
    doc: Input fasta/fastq file, supports multiple '-2'
    inputBinding:
      position: 102
  - id: read_length
    type:
      - 'null'
      - int
    doc: 'Read length, default: 0 variable'
    inputBinding:
      position: 101
      prefix: -l
  - id: max_mismatches
    type:
      - 'null'
      - int
    doc: Maximum mismatches [4]
    inputBinding:
      position: 101
      prefix: -m
  - id: exact_match_threshold
    type:
      - 'null'
      - int
    doc: Exactly matching threshold [2000]
    inputBinding:
      position: 101
      prefix: -e
  - id: low_polymorphism
    type:
      - 'null'
      - boolean
    doc: Low level of polymorphism
    inputBinding:
      position: 101
      prefix: -L
outputs:
  - id: stdout
    type: stdout
    doc: 'Clusters: seqid, cluster id, read1, read2'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rainbow:2.0.4--pl5321h7b50bb2_11
stdout: rainbow_cluster.out
