cwlVersion: v1.2
class: CommandLineTool
baseCommand: GLIMPSE2_chunk
label: glimpse-bio_GLIMPSE2_chunk
doc: "The provided text does not contain help information or usage instructions. It
  appears to be an error log related to a container execution failure (no space left
  on device).\n\nTool homepage: https://odelaneau.github.io/GLIMPSE/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/glimpse-bio:2.0.1--ha5d29c5_3
stdout: glimpse-bio_GLIMPSE2_chunk.out
