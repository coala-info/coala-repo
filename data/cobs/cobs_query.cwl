cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cobs
  - query
label: cobs_query
doc: "Query the COBS index\n\nTool homepage: https://panthema.net/cobs"
inputs:
  - id: query
    type:
      - 'null'
      - string
    doc: the text sequence to search for
    inputBinding:
      position: 1
  - id: index
    type:
      - 'null'
      - Directory
    doc: path to index file(s)
    inputBinding:
      position: 102
      prefix: --index
  - id: index_sizes
    type:
      - 'null'
      - string
    doc: 'WARNING: HIDDEN OPTION. USE ONLY IF YOU KNOW WHAT YOU ARE DOING. Precomputed
      file sizes of the index. Useful if --load-complete is given and indexes are
      streamed into COBS. This is a hidden option to be used with mof. This also implies
      COBS classic index, skipping double header reading due to streaming.'
    inputBinding:
      position: 102
      prefix: --index-sizes
  - id: limit
    type:
      - 'null'
      - int
    doc: number of results to return
    default: all
    inputBinding:
      position: 102
      prefix: --limit
  - id: load_complete
    type:
      - 'null'
      - boolean
    doc: load complete index into RAM for batch queries
    inputBinding:
      position: 102
      prefix: --load-complete
  - id: query_file
    type:
      - 'null'
      - File
    doc: query (fasta) file to process
    inputBinding:
      position: 102
      prefix: --file
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use
    default: max cores
    inputBinding:
      position: 102
      prefix: --threads
  - id: threshold
    type:
      - 'null'
      - float
    doc: threshold in percentage of terms in query matching
    default: 0.8
    inputBinding:
      position: 102
      prefix: --threshold
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cobs:0.3.1--hdcf5f25_0
stdout: cobs_query.out
