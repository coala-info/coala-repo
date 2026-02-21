cwlVersion: v1.2
class: CommandLineTool
baseCommand: spclust_mpispclust
label: spclust_mpispclust
doc: "The provided text does not contain help information or a description of the
  tool's functionality; it contains error logs from a container build process.\n\n
  Tool homepage: https://github.com/johnymatar/SpCLUST/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spclust:28.5.19--h425c490_1
stdout: spclust_mpispclust.out
