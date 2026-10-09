cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lexicmap
  - utils
  - genomes
label: lexicmap_utils_genomes
doc: "View genome IDs in the index.\n\nTool homepage: https://github.com/shenwei356/LexicMap"
inputs:
  - id: index
    type: Directory
    doc: 'Index directory created by "lexicmap index".'
    inputBinding:
      position: 1
      prefix: -d
  - id: out_file
    type:
      - 'null'
      - string
    doc: 'Out file, supports the ".gz" suffix'
    inputBinding:
      position: 2
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
    doc: 'The genome IDs'
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
