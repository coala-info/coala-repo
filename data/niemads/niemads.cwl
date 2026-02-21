cwlVersion: v1.2
class: CommandLineTool
baseCommand: niemads
label: niemads
doc: "The provided text does not contain help information or usage instructions for
  the tool 'niemads'. It contains error logs related to a container runtime (Apptainer/Singularity)
  failure due to insufficient disk space.\n\nTool homepage: https://github.com/niemasd/NiemaDS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/niemads:1.0.16--pyh7cba7a3_0
stdout: niemads.out
