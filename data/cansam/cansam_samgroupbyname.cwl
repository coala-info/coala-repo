cwlVersion: v1.2
class: CommandLineTool
baseCommand: cansam_samgroupbyname
label: cansam_samgroupbyname
doc: "The provided text does not contain help information for the tool. It consists
  of system logs indicating a failure to build or extract a container image due to
  insufficient disk space.\n\nTool homepage: https://github.com/jmarshall/cansam"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cansam:21d64bb--h4ef8376_2
stdout: cansam_samgroupbyname.out
