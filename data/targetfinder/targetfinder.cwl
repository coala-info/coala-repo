cwlVersion: v1.2
class: CommandLineTool
baseCommand: targetfinder
label: targetfinder
doc: "The provided text does not contain help information for targetfinder; it contains
  error logs from a container runtime (Apptainer/Singularity) attempting to fetch
  the tool's image.\n\nTool homepage: https://github.com/shwhalen/targetfinder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/targetfinder:1.7--0
stdout: targetfinder.out
