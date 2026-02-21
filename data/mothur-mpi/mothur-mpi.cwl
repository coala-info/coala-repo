cwlVersion: v1.2
class: CommandLineTool
baseCommand: mothur
label: mothur-mpi
doc: "Mothur is a comprehensive software package for analyzing microbiome data. (Note:
  The provided text contains system error messages and does not list specific tool
  arguments.)\n\nTool homepage: https://www.mothur.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/mothur-mpi:v1.38.1.1-1-deb_cv1
stdout: mothur-mpi.out
