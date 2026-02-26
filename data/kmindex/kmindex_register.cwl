cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmindex register
label: kmindex_register
doc: "Register index.\n\nTool homepage: https://github.com/tlemane/kmindex"
inputs:
  - id: from_file
    type:
      - 'null'
      - string
    doc: A tab-separated file with index_name<tab>index_path per line.
    inputBinding:
      position: 101
      prefix: --from-file
  - id: global_index
    type: string
    doc: Global index path.
    inputBinding:
      position: 101
      prefix: --global-index
  - id: index_path
    type:
      - 'null'
      - string
    doc: Index path (a kmtricks run). (ignored with --from-file)
    inputBinding:
      position: 101
      prefix: --index-path
  - id: mode
    type:
      - 'null'
      - string
    doc: Register mode [symlink|copy|move]
    default: symlink
    inputBinding:
      position: 101
      prefix: --mode
  - id: name
    type:
      - 'null'
      - string
    doc: Index name. (ignored with --from-file)
    inputBinding:
      position: 101
      prefix: --name
  - id: verbose
    type:
      - 'null'
      - string
    doc: Verbosity level [debug|info|warning|error]
    default: info
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmindex:0.6.0--h668145b_1
stdout: kmindex_register.out
