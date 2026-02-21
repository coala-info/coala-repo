cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - obimatrix
label: obitools4_obimatrix
doc: "The provided text does not contain help information or a description of the
  tool; it contains system error logs related to a container runtime failure.\n\n
  Tool homepage: https://obitools4.metabarcoding.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/obitools4:4.4.0--h6e5cb0d_0
stdout: obitools4_obimatrix.out
