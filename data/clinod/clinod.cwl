cwlVersion: v1.2
class: CommandLineTool
baseCommand: clinod
label: clinod
doc: "The provided text is an error log from a container build process and does not
  contain the tool's help documentation or usage instructions. As a result, no arguments
  could be extracted.\n\nTool homepage: https://github.com/RogerioAP/Clinodonto-Soft"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clinod:1.3--py27_0
stdout: clinod.out
