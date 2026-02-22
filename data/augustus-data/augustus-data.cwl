cwlVersion: v1.2
class: CommandLineTool
baseCommand: augustus-data
label: augustus-data
doc: "The provided text is an error log from a container runtime and does not contain
  help information or usage instructions for the tool.\n\nTool homepage: http://bioinf.uni-greifswald.de/augustus/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/augustus-data:v3.3.2dfsg-2-deb_cv1
stdout: augustus-data.out
