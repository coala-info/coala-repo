cwlVersion: v1.2
class: CommandLineTool
baseCommand: traitar
label: traitar
doc: "The provided text does not contain help information for the tool 'traitar'.
  It is an error log from a container runtime (Apptainer/Singularity) indicating a
  failure to build the image due to insufficient disk space.\n\nTool homepage: http://github.com/aweimann/traitar"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/traitar:3.0.1--pyhdfd78af_0
stdout: traitar.out
