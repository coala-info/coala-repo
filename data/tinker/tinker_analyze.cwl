cwlVersion: v1.2
class: CommandLineTool
baseCommand: analyze
label: tinker_analyze
doc: "The provided text does not contain help information for the tool. It appears
  to be a fatal error log from a container runtime (Apptainer/Singularity) failing
  to fetch a Docker image.\n\nTool homepage: https://dasher.wustl.edu/tinker/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
stdout: tinker_analyze.out
