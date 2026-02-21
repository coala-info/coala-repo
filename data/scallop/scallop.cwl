cwlVersion: v1.2
class: CommandLineTool
baseCommand: scallop
label: scallop
doc: "The provided text does not contain help information for the tool 'scallop'.
  It appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  attempting to fetch a Docker image.\n\nTool homepage: https://github.com/Kingsford-Group/scallop"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scallop:0.10.5--hea69786_9
stdout: scallop.out
