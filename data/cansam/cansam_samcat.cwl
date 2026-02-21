cwlVersion: v1.2
class: CommandLineTool
baseCommand: cansam_samcat
label: cansam_samcat
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be an error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build or extract the container image due to lack of disk
  space.\n\nTool homepage: https://github.com/jmarshall/cansam"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cansam:21d64bb--h4ef8376_2
stdout: cansam_samcat.out
