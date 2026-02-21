cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - GLIMPSE2_ligate
label: glimpse-bio_GLIMPSE2_ligate
doc: "Ligate multiple chunks of imputed data into a single file.\n\nTool homepage:
  https://odelaneau.github.io/GLIMPSE/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/glimpse-bio:2.0.1--ha5d29c5_3
stdout: glimpse-bio_GLIMPSE2_ligate.out
