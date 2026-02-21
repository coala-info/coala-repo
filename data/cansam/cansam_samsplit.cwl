cwlVersion: v1.2
class: CommandLineTool
baseCommand: cansam_samsplit
label: cansam_samsplit
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a log of a failed container build process (Apptainer/Singularity)
  due to insufficient disk space.\n\nTool homepage: https://github.com/jmarshall/cansam"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cansam:21d64bb--h4ef8376_2
stdout: cansam_samsplit.out
