cwlVersion: v1.2
class: CommandLineTool
baseCommand: mapula
label: mapula
doc: "The provided text does not contain help documentation or usage instructions
  for the tool 'mapula'. It contains system log messages and a fatal error regarding
  container image building (no space left on device).\n\nTool homepage: https://github.com/epi2me-labs/mapula"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mapula:2.1.2--pyhdfd78af_0
stdout: mapula.out
