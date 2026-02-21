cwlVersion: v1.2
class: CommandLineTool
baseCommand: seq_crumbs_filter_by_complexity
label: seq_crumbs_filter_by_complexity
doc: "Filter sequences by complexity (Note: The provided help text contains only system
  error logs and no usage information).\n\nTool homepage: https://github.com/JoseBlanca/seq_crumbs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sequana_pipetools:1.3.1--pyhdfd78af_0
stdout: seq_crumbs_filter_by_complexity.out
