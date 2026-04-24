cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kmindex
  - index-infos
label: kmindex_index-infos
doc: "Print index informations.\n\nTool homepage: https://github.com/tlemane/kmindex"
inputs:
  - id: index
    type: string
    doc: Global index path.
    inputBinding:
      position: 101
      prefix: --index
  - id: verbose
    type:
      - 'null'
      - string
    doc: Verbosity level [debug|info|warning|error].
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
stdout: kmindex_index-infos.out
