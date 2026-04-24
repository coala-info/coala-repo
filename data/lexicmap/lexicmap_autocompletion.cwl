cwlVersion: v1.2
class: CommandLineTool
baseCommand: lexicmap
label: lexicmap_autocompletion
doc: "Generate shell autocompletion scripts\n\nTool homepage: https://github.com/shenwei356/LexicMap"
inputs:
  - id: file
    type:
      - 'null'
      - string
    doc: autocompletion file
    inputBinding:
      position: 101
      prefix: --file
  - id: infile_list
    type:
      - 'null'
      - File
    doc: File of input file list (one file per line). If given, they are 
      appended to files from CLI arguments.
    inputBinding:
      position: 101
      prefix: --infile-list
  - id: log
    type:
      - 'null'
      - string
    doc: Log file.
    inputBinding:
      position: 101
      prefix: --log
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not print any verbose information. But you can write them to a file 
      with --log.
    inputBinding:
      position: 101
      prefix: --quiet
  - id: shell
    type:
      - 'null'
      - string
    doc: autocompletion type (bash|zsh|fish|powershell)
    inputBinding:
      position: 101
      prefix: --shell
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU cores to use. By default, it uses all available cores.
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lexicmap:0.8.1--h9ee0642_1
stdout: lexicmap_autocompletion.out
