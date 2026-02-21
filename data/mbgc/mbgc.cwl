cwlVersion: v1.2
class: CommandLineTool
baseCommand: mbgc
label: mbgc
doc: "The provided text does not contain help information for the tool 'mbgc'. It
  contains error logs related to a container runtime (Apptainer/Singularity) failure
  due to insufficient disk space.\n\nTool homepage: https://github.com/kowallus/mbgc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mbgc:2.1--h9948957_0
stdout: mbgc.out
