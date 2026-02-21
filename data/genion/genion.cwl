cwlVersion: v1.2
class: CommandLineTool
baseCommand: genion
label: genion
doc: "The provided text does not contain help information for the tool 'genion'. It
  appears to be a system error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build the container image due to lack of disk space.\n\n
  Tool homepage: https://github.com/vpc-ccg/genion"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genion:1.2.3--h077b44d_2
stdout: genion.out
