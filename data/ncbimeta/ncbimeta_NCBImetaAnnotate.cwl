cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncbimeta_NCBImetaAnnotate
label: ncbimeta_NCBImetaAnnotate
doc: "The provided text does not contain help information or a description of the
  tool; it contains system error logs related to a container runtime failure.\n\n
  Tool homepage: https://github.com/ktmeaton/NCBImeta"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ncbimeta:0.8.3--pyhdfd78af_0
stdout: ncbimeta_NCBImetaAnnotate.out
