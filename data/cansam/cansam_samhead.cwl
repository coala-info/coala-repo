cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cansam
  - samhead
label: cansam_samhead
doc: "The provided text does not contain help information for the tool. It consists
  of system logs and a fatal error indicating a failure to build a container image
  due to lack of disk space. No arguments or descriptions could be extracted from
  the input.\n\nTool homepage: https://github.com/jmarshall/cansam"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cansam:21d64bb--h4ef8376_2
stdout: cansam_samhead.out
