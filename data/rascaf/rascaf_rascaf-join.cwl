cwlVersion: v1.2
class: CommandLineTool
baseCommand: rascaf-join
label: rascaf_rascaf-join
doc: "The provided text does not contain help information for the tool. It consists
  of system logs and a fatal error message related to a container build failure.\n
  \nTool homepage: https://github.com/mourisl/Rascaf"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rascaf:20180710--h5ca1c30_1
stdout: rascaf_rascaf-join.out
