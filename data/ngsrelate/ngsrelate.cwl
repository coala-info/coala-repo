cwlVersion: v1.2
class: CommandLineTool
baseCommand: ngsrelate
label: ngsrelate
doc: "The provided text does not contain help information or usage instructions for
  ngsrelate. It appears to be a system error log regarding a container build failure
  (no space left on device).\n\nTool homepage: https://github.com/ANGSD/NgsRelate"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngsrelate:2.0--hea85c65_0
stdout: ngsrelate.out
