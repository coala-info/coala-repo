cwlVersion: v1.2
class: CommandLineTool
baseCommand: gatb-core-testdata
label: gatb-core-testdata
doc: "GATB-core test data package. Note: The provided text contains system error logs
  regarding container image retrieval and does not list specific command-line arguments.\n
  \nTool homepage: https://gatb.inria.fr/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/gatb-core-testdata:v1.4.1git20181225.44d5a44dfsg-3-deb_cv1
stdout: gatb-core-testdata.out
