cwlVersion: v1.2
class: CommandLineTool
baseCommand: probabel_pacoxph
label: probabel_pacoxph
doc: "The provided text does not contain help information for the tool; it is a container
  runtime error log. ProbaBel pacoxph is typically used for probabilistic analysis
  of Cox proportional hazards models in genome-wide association studies.\n\nTool homepage:
  https://github.com/GenABEL-Project/ProbABEL"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/probabel:v0.5.0dfsg-3-deb_cv1
stdout: probabel_pacoxph.out
