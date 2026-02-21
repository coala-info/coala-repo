cwlVersion: v1.2
class: CommandLineTool
baseCommand: im-pipelines
label: im-pipelines
doc: "The provided text does not contain help information or usage instructions; it
  is an error log from a container runtime (Apptainer/Singularity) indicating a failure
  to pull the container image due to lack of disk space.\n\nTool homepage: https://github.com/InformaticsMatters/pipelines"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/im-pipelines:1.1.6--pyh3252c3a_0
stdout: im-pipelines.out
