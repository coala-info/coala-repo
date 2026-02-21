cwlVersion: v1.2
class: CommandLineTool
baseCommand: pisces
label: pisces
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a log of a container build process followed by an execution error
  (dotnet: command not found).\n\nTool homepage: https://github.com/Illumina/Pisces"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pisces:5.2.10.49--0
stdout: pisces.out
