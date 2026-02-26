cwlVersion: v1.2
class: CommandLineTool
baseCommand: docker run
label: biopython
doc: "Run a Docker container for Biopython.\n\nTool homepage: http://www.biopython.org/"
inputs:
  - id: image
    type: string
    doc: The Docker image to run (e.g., 'quay.io/biocontainers/biopython:1.84')
    inputBinding:
      position: 1
  - id: command_and_args
    type:
      - 'null'
      - type: array
        items: string
    doc: The command and arguments to run inside the container
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biopython:1.84
stdout: biopython.out
