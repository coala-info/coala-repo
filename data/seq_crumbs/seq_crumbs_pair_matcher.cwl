cwlVersion: v1.2
class: CommandLineTool
baseCommand: seq_crumbs_pair_matcher
label: seq_crumbs_pair_matcher
doc: "The provided text does not contain help information or usage instructions for
  the tool. It is a log of a failed container build process due to insufficient disk
  space.\n\nTool homepage: https://github.com/JoseBlanca/seq_crumbs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sequana_pipetools:1.3.1--pyhdfd78af_0
stdout: seq_crumbs_pair_matcher.out
