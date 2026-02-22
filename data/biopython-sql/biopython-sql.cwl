cwlVersion: v1.2
class: CommandLineTool
baseCommand: biopython-sql
label: biopython-sql
doc: "The provided text does not contain help information or a description of the
  tool; it contains system error messages related to a container runtime failure (no
  space left on device).\n\nTool homepage: http://www.biopython.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/biopython-sql:v1.68dfsg-3-deb-py3_cv1
stdout: biopython-sql.out
