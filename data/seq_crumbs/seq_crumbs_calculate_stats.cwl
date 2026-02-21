cwlVersion: v1.2
class: CommandLineTool
baseCommand: seq_crumbs_calculate_stats
label: seq_crumbs_calculate_stats
doc: "The provided text does not contain help information for the tool. It is an error
  log indicating a failure to build a container image due to insufficient disk space.\n
  \nTool homepage: https://github.com/JoseBlanca/seq_crumbs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sequana_pipetools:1.3.1--pyhdfd78af_0
stdout: seq_crumbs_calculate_stats.out
