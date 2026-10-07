cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - deacon
  - index
  - fetch
label: deacon_index_fetch
doc: "Fetch a pre-built index from remote storage\n\nTool homepage: https://github.com/bede/deacon"
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
inputs:
  - id: index_name
    type:
      - 'null'
      - string
    doc: Index name (e.g., panhuman-1)
    inputBinding:
      position: 1
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: K-mer length
    inputBinding:
      position: 101
      prefix: -k
  - id: window_size
    type:
      - 'null'
      - int
    doc: Minimizer window size
    inputBinding:
      position: 101
      prefix: -w
  - id: output
    type:
      - 'null'
      - string
    doc: Path to output file (default ./)
    inputBinding:
      position: 101
      prefix: --output
outputs:
  - id: index
    type: File[]
    doc: Downloaded index file
    outputBinding:
      glob: "${ return inputs.output ? inputs.output : '*.idx'; }"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deacon:0.13.2--h7ef3eeb_1
