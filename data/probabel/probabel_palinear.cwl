cwlVersion: v1.2
class: CommandLineTool
baseCommand: palinear
label: probabel_palinear
doc: "The provided text does not contain help information for the tool. It appears
  to be a log of a failed container build/fetch operation. No arguments could be extracted.\n
  \nTool homepage: https://github.com/GenABEL-Project/ProbABEL"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/probabel:v0.5.0dfsg-3-deb_cv1
stdout: probabel_palinear.out
