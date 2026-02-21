cwlVersion: v1.2
class: CommandLineTool
baseCommand: Bandage
label: bandage_ng_Bandage
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a system error log indicating a failure to build or extract
  a container image due to insufficient disk space.\n\nTool homepage: https://github.com/asl/BandageNG"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bandage_ng:2026.2.1--h3751afb_0
stdout: bandage_ng_Bandage.out
