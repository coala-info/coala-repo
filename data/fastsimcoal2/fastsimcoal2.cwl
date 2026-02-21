cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastsimcoal2
label: fastsimcoal2
doc: "The provided text does not contain help information or a description of the
  tool; it contains system error messages related to a container runtime failure (no
  space left on device).\n\nTool homepage: http://cmpg.unibe.ch/software/fastsimcoal27/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastsimcoal2:27093--hdfd78af_0
stdout: fastsimcoal2.out
