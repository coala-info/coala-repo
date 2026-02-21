cwlVersion: v1.2
class: CommandLineTool
baseCommand: msisensor
label: msisensor
doc: "The provided text does not contain help information for msisensor; it contains
  system logs and a fatal error regarding container execution (no space left on device).\n
  \nTool homepage: https://github.com/ding-lab/msisensor"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msisensor:0.5--h1b3a749_7
stdout: msisensor.out
