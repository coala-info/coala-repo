cwlVersion: v1.2
class: CommandLineTool
baseCommand: famus
label: famus
doc: "The provided text does not contain help information or a description of the
  tool; it contains system error messages related to a container runtime failure.\n
  \nTool homepage: https://github.com/burstein-lab/famus"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/famus:0.2.2--py312hdfd78af_0
stdout: famus.out
