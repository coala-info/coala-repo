cwlVersion: v1.2
class: CommandLineTool
baseCommand: spclust
label: spclust
doc: "A tool for spatial clustering (Note: The provided text is a container build
  log and does not contain usage instructions or argument definitions).\n\nTool homepage:
  https://github.com/johnymatar/SpCLUST/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spclust:28.5.19--h425c490_1
stdout: spclust.out
