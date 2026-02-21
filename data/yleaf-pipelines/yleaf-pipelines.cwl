cwlVersion: v1.2
class: CommandLineTool
baseCommand: yleaf-pipelines
label: yleaf-pipelines
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  failing to fetch or build the tool's image.\n\nTool homepage: https://github.com/trianglegrrl/Yleaf-pipelines"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/yleaf-pipelines:3.3.0--pyh7e72e81_0
stdout: yleaf-pipelines.out
