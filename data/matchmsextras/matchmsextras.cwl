cwlVersion: v1.2
class: CommandLineTool
baseCommand: matchmsextras
label: matchmsextras
doc: "The provided text does not contain help information for the tool; it contains
  container runtime error logs regarding a failure to build a SIF image due to lack
  of disk space.\n\nTool homepage: https://github.com/matchms/matchmsextras"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/matchmsextras:0.4.2--pyhdfd78af_0
stdout: matchmsextras.out
