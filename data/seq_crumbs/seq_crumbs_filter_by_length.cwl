cwlVersion: v1.2
class: CommandLineTool
baseCommand: seq_crumbs_filter_by_length
label: seq_crumbs_filter_by_length
doc: "Filter sequences by length (Note: The provided help text contains system error
  messages regarding a failed container build and does not list specific tool arguments).\n
  \nTool homepage: https://github.com/JoseBlanca/seq_crumbs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sequana_pipetools:1.3.1--pyhdfd78af_0
stdout: seq_crumbs_filter_by_length.out
