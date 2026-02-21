cwlVersion: v1.2
class: CommandLineTool
baseCommand: kissplice_bcalm
label: kissplice_bcalm
doc: "The provided text does not contain help information for kissplice_bcalm; it
  contains container runtime error messages indicating a failure to pull the image
  due to lack of disk space.\n\nTool homepage: http://kissplice.prabi.fr"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kissplice:2.6.5--h077b44d_1
stdout: kissplice_bcalm.out
