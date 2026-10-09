cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lexicmap
  - utils
  - merge-search-results
label: lexicmap_utils_merge_search_results
doc: "Merge search results from multiple indexes (several files for the same queries).\n\nTool homepage: https://github.com/shenwei356/LexicMap"
inputs:
  - id: search_results
    type:
      type: array
      items: File
    doc: 'Search result files from lexicmap search.'
    inputBinding:
      position: 1
  - id: buffer_size
    type:
      - 'null'
      - string
    doc: 'Size of buffer, supported unit: K, M, G. [20M]'
    inputBinding:
      position: 2
      prefix: -b
  - id: out_file
    type:
      - 'null'
      - string
    doc: 'Out file, supports the ".gz" suffix'
    inputBinding:
      position: 3
      prefix: -o
  - id: query
    type:
      - 'null'
      - string
    doc: 'Query ID to merge'
    inputBinding:
      position: 4
      prefix: -q
  - id: infile_list
    type:
      - 'null'
      - File
    doc: 'File of input file list (one file per line). If given, they are appended to files from CLI arguments.'
    inputBinding:
      position: 90
      prefix: -X
  - id: log
    type:
      - 'null'
      - string
    doc: 'Log file.'
    inputBinding:
      position: 91
      prefix: --log
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: 'Do not print any verbose information. But you can write them to a file with --log.'
    inputBinding:
      position: 92
      prefix: --quiet
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of CPU cores to use. By default, it uses all available cores.'
    inputBinding:
      position: 93
      prefix: -j
outputs:
  - id: output
    type: File?
    doc: 'The merged search result'
    outputBinding:
      glob: $(inputs.out_file)
  - id: log_out
    type: File?
    doc: 'Log file, written when log is set'
    outputBinding:
      glob: $(inputs.log)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lexicmap:0.8.1--h9ee0642_1
