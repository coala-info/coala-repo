cwlVersion: v1.2
class: CommandLineTool
baseCommand: quaqc
label: quaqc
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a series of log messages and a fatal error from a container runtime
  (Apptainer/Singularity) attempting to fetch a Docker image.\n\nTool homepage: https://github.com/bjmt/quaqc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/quaqc:1.5--h577a1d6_0
stdout: quaqc.out
