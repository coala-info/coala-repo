cwlVersion: v1.2
class: CommandLineTool
baseCommand: docker run
label: igua
doc: "Run a Docker container for the igua tool.\n\nTool homepage: https://github.com/zellerlab/IGUA"
inputs:
  - id: image
    type: string
    doc: The Docker image to run (e.g., 
      quay.io/biocontainers/igua:0.1.0--py39h5b94c0b_0)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igua:0.1.0--py39h5b94c0b_0
stdout: igua.out
