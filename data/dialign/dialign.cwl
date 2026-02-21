cwlVersion: v1.2
class: CommandLineTool
baseCommand: dialign
label: dialign
doc: "DIALIGN is a software tool for multiple sequence alignment. (Note: The provided
  input text appears to be a container runtime error log rather than the tool's help
  documentation, so no arguments could be extracted.)\n\nTool homepage: https://github.com/GuillaumeDD/dialign"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/dialign:v2.2.1-10-deb_cv1
stdout: dialign.out
