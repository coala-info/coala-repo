cwlVersion: v1.2
class: CommandLineTool
baseCommand: seq_crumbs_trim_edges
label: seq_crumbs_trim_edges
doc: "The provided text does not contain help information for the tool; it is a system
  error log indicating a 'no space left on device' failure during a container build
  process.\n\nTool homepage: https://github.com/JoseBlanca/seq_crumbs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sequana_pipetools:1.3.1--pyhdfd78af_0
stdout: seq_crumbs_trim_edges.out
