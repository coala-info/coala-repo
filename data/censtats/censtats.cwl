cwlVersion: v1.2
class: CommandLineTool
baseCommand: censtats
label: censtats
doc: "The provided text does not contain help information for the tool. It contains
  system logs and a fatal error message regarding a container build failure (no space
  left on device).\n\nTool homepage: https://github.com/logsdon-lab/CenStats"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/censtats:0.1.3--pyhdfd78af_0
stdout: censtats.out
