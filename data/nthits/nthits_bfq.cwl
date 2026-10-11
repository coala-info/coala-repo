cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nthits-bfq
label: nthits_bfq
doc: "Query tool for ntHits' output Bloom filter\n\nTool homepage:
  https://github.com/bcgsc/ntHits"
inputs:
  - id: cbf
    type:
      - 'null'
      - boolean
    doc: Treat input file as a counting Bloom filter and output k-mer counts
    inputBinding:
      position: 1
      prefix: --cbf
  - id: excluded_bf
    type:
      - 'null'
      - File
    doc: Path to the Bloom filter containing excluded k-mers
    inputBinding:
      position: 2
      prefix: -ex
  - id: bf_path
    type: File
    doc: Input Bloom filter file
    inputBinding:
      position: 3
  - id: data_path
    type: File
    doc: Path to input dataset (sequences to query)
    inputBinding:
      position: 4
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nthits:1.0.3--h4ac6f70_1
stdout: nthits_bfq.out
