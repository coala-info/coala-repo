cwlVersion: v1.2
class: CommandLineTool
baseCommand: emmix
label: emmix
doc: "The provided text does not contain help information for the tool 'emmix'. It
  contains error logs related to a container runtime (Apptainer/Singularity) failure
  due to insufficient disk space.\n\nTool homepage: https://github.com/suren-rathnayake/EMMIXmfa"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/emmix:1.3--h470a237_2
stdout: emmix.out
