cwlVersion: v1.2
class: CommandLineTool
baseCommand: razers3
label: razers3
doc: "The provided text does not contain help information for razers3; it contains
  error logs from a container build process.\n\nTool homepage: https://www.seqan.de/apps/razers3.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/razers3:3.5.8--haf24da9_7
stdout: razers3.out
