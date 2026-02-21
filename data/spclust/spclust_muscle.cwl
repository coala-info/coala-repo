cwlVersion: v1.2
class: CommandLineTool
baseCommand: spclust_muscle
label: spclust_muscle
doc: "The provided text contains system logs and error messages related to a container
  build process rather than the help documentation for the tool. Consequently, no
  command-line arguments could be extracted.\n\nTool homepage: https://github.com/johnymatar/SpCLUST/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spclust:28.5.19--h425c490_1
stdout: spclust_muscle.out
