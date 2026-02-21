cwlVersion: v1.2
class: CommandLineTool
baseCommand: sequana_sequanix
label: sequana_sequanix
doc: "The provided text does not contain help information or usage instructions for
  sequana_sequanix. It contains system logs and a fatal error message regarding a
  container build failure (no space left on device).\n\nTool homepage: https://sequana.readthedocs.io"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sequana:0.19.6--pyhdfd78af_0
stdout: sequana_sequanix.out
