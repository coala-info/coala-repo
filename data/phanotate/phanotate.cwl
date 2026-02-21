cwlVersion: v1.2
class: CommandLineTool
baseCommand: phanotate
label: phanotate
doc: "The provided text does not contain help information or usage instructions for
  phanotate; it is a log of a failed container build/extraction due to insufficient
  disk space.\n\nTool homepage: https://github.com/deprekate/PHANOTATE"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phanotate:1.6.7--py310h184ae93_1
stdout: phanotate.out
