cwlVersion: v1.2
class: CommandLineTool
baseCommand: murasaki-mpi
label: murasaki-mpi
doc: "Murasaki is a multiple genome alignment tool. (Note: The provided input text
  contains container runtime error messages rather than the tool's help documentation,
  so no arguments could be extracted.)"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/murasaki-mpi:v1.68.6-6b4-deb_cv1
stdout: murasaki-mpi.out
