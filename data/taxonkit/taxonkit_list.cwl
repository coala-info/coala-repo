cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - taxonkit
  - list
label: taxonkit_list
doc: "List taxonomic subtrees of given TaxIds\n\nTool homepage: https://github.com/shenwei356/taxonkit"
inputs:
  - id: data_dir
    type:
      - 'null'
      - string
    doc: directory containing nodes.dmp and names.dmp
    inputBinding:
      position: 101
      prefix: --data-dir
  - id: indent
    type:
      - 'null'
      - string
    doc: indent
    inputBinding:
      position: 101
      prefix: --indent
  - id: json
    type:
      - 'null'
      - boolean
    doc: "output in JSON format. you can save the result in file with suffix \".json\"\
      \ and\n                        open with modern text editor"
    inputBinding:
      position: 101
      prefix: --json
  - id: line_buffered
    type:
      - 'null'
      - boolean
    doc: "use line buffering on output, i.e., immediately writing to stdin/file for\n\
      \                          every line of output"
    inputBinding:
      position: 101
      prefix: --line-buffered
  - id: show_name
    type:
      - 'null'
      - boolean
    doc: output scientific name
    inputBinding:
      position: 101
      prefix: --show-name
  - id: show_rank
    type:
      - 'null'
      - boolean
    doc: output rank
    inputBinding:
      position: 101
      prefix: --show-rank
  - id: taxids
    type:
      - 'null'
      - type: array
        items: string
    doc: TaxId(s), multiple values should be separated by comma
    inputBinding:
      position: 101
      prefix: --ids
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
