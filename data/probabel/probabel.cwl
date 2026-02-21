cwlVersion: v1.2
class: CommandLineTool
baseCommand: probabel
label: probabel
doc: "Probabel is a toolset for genome-wide association analysis of imputed genetic
  data. (Note: The provided text is a container runtime error log and does not contain
  help information or argument definitions.)\n\nTool homepage: https://github.com/GenABEL-Project/ProbABEL"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/probabel:v0.5.0dfsg-3-deb_cv1
stdout: probabel.out
