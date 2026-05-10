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
    inputBinding:
      position: 101
      prefix: --file
  - id: data_dir
    type:
      - 'null'
      - string
    doc: directory containing nodes.dmp and names.dmp
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
    inputBinding:
      position: 101
      prefix: --shell
  - id: threads
    type:
      - 'null'
      - int
    doc: number of CPUs. 4 is enough
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
  - id: out_file_path
    type: string
    doc: Output or path parameter `out_file_path`
    inputBinding:
      position: 102
      prefix: --out-file
outputs:
  - id: out_file
    type:
      - 'null'
      - File
    doc: out file ("-" for stdout, suffix .gz for gzipped out)
    outputBinding:
      glob: $(inputs.out_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxonkit:0.20.0--h9ee0642_1
