cwlVersion: v1.2
class: CommandLineTool
baseCommand: GLIMPSE2_split_reference
label: glimpse-bio_GLIMPSE2_split_reference
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains system log messages and a fatal error regarding container
  image building (no space left on device).\n\nTool homepage: https://odelaneau.github.io/GLIMPSE/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/glimpse-bio:2.0.1--ha5d29c5_3
stdout: glimpse-bio_GLIMPSE2_split_reference.out
