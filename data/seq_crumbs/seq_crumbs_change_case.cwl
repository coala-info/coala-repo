cwlVersion: v1.2
class: CommandLineTool
baseCommand: seq_crumbs_change_case
label: seq_crumbs_change_case
doc: "The provided text does not contain help information for the tool. It is an error
  log indicating a failure to build or run a container due to lack of disk space.\n
  \nTool homepage: https://github.com/JoseBlanca/seq_crumbs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sequana_pipetools:1.3.1--pyhdfd78af_0
stdout: seq_crumbs_change_case.out
