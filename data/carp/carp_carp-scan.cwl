cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - carp-scan
label: carp_carp-scan
doc: "The provided text does not contain help information for the tool. It consists
  of system logs indicating a failure to build or run a container image due to insufficient
  disk space.\n\nTool homepage: https://github.com/gi-bielefeld/scj-carp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/carp:0.1.1--h4349ce8_0
stdout: carp_carp-scan.out
