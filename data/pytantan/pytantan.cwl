cwlVersion: v1.2
class: CommandLineTool
baseCommand: pytantan
label: pytantan
doc: "The provided text does not contain help information or usage instructions for
  the tool. It consists of container build logs and a fatal error message regarding
  an OCI image fetch failure.\n\nTool homepage: https://github.com/althonos/pytantan"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pytantan:0.1.3--py312hdcc493e_1
stdout: pytantan.out
