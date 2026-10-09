cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lexicmap
  - utils
  - 2blast
label: lexicmap_utils_2blast
doc: "Convert the tabular search result of \"lexicmap search -a\" to a Blast-style alignment format.\n\nTool homepage: https://github.com/shenwei356/LexicMap"
inputs:
  - id: search_results
    type:
      type: array
      items: File
    doc: 'Search result files (tabular output of lexicmap search with -a/--all).'
    inputBinding:
      position: 1
  - id: buffer_size
    type:
      - 'null'
      - string
    doc: 'Size of buffer, supported unit: K, M, G. Increase it when "bufio.Scanner: token too long" is reported. [20M]'
    inputBinding:
      position: 2
      prefix: -b
  - id: ignore_case
    type:
      - 'null'
      - boolean
    doc: 'Ignore cases of sgenome and sseqid'
    inputBinding:
      position: 3
      prefix: -i
  - id: kv_file_genome
    type:
      - 'null'
      - File
    doc: 'Two-column tabular file for mapping the target genome ID (sgenome) to the corresponding value'
    inputBinding:
      position: 4
      prefix: -g
  - id: kv_file_seq
    type:
      - 'null'
      - File
    doc: 'Two-column tabular file for mapping the target sequence ID (sseqid) to the corresponding value'
    inputBinding:
      position: 5
      prefix: -s
  - id: out_file
    type:
      - 'null'
      - string
    doc: 'Out file, supports and recommends a ".gz" suffix'
    inputBinding:
      position: 6
      prefix: -o
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
    doc: 'The Blast-style alignment text'
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
