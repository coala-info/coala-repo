cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - taxonkit
  - genautocomplete
label: taxonkit_genautocomplete
doc: "generate shell autocompletion script\n\nTool homepage: https://github.com/shenwei356/taxonkit"
inputs:
  - id: autocompletion_file
    type:
      - 'null'
      - string
    doc: autocompletion file
    default: /root/.bash_completion.d/taxonkit.sh
    inputBinding:
      position: 101
      prefix: --file
  - id: data_dir
    type:
      - 'null'
      - string
    doc: directory containing nodes.dmp and names.dmp
    default: /root/.taxonkit
    inputBinding:
      position: 101
      prefix: --data-dir
  - id: line_buffered
    type:
      - 'null'
      - boolean
    doc: use line buffering on output, i.e., immediately writing to stdin/file 
      for every line of output
    inputBinding:
      position: 101
      prefix: --line-buffered
  - id: shell_type
    type:
      - 'null'
      - string
    doc: autocompletion type (bash|zsh|fish|powershell)
    default: bash
    inputBinding:
      position: 101
      prefix: --shell
  - id: threads
    type:
      - 'null'
      - int
    doc: number of CPUs. 4 is enough
    default: 4
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: print verbose information
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: out_file
    type:
      - 'null'
      - File
    doc: out file ("-" for stdout, suffix .gz for gzipped out)
    outputBinding:
      glob: $(inputs.out_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxonkit:0.20.0--h9ee0642_1
