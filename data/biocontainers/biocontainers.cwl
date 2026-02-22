cwlVersion: v1.2
class: CommandLineTool
baseCommand: biocontainers
label: biocontainers
doc: "The provided text appears to be error logs from a container runtime (likely
  Singularity) attempting to pull or convert a Docker image, rather than help text
  for a command-line tool. As a result, no arguments or usage patterns could be identified.\n\
  \nTool homepage: https://github.com/BioContainers/containers"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/biocontainers:08252016-4
stdout: biocontainers.out
