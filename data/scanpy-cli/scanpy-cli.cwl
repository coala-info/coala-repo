cwlVersion: v1.2
class: CommandLineTool
baseCommand: scanpy-cli
label: scanpy-cli
doc: "The provided text does not contain help information for scanpy-cli; it is an
  error log from a container runtime (Singularity/Apptainer) failing to pull the scanpy-cli
  image.\n\nTool homepage: https://github.com/nictru/scanpy-cli"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scanpy-cli:0.2.0--pyhdfd78af_0
stdout: scanpy-cli.out
