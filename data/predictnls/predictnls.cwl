cwlVersion: v1.2
class: CommandLineTool
baseCommand: predictnls
label: predictnls
doc: Prediction of nuclear localization signals (NLSs)
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/predictnls:v1.0.20-5-deb_cv1
stdout: predictnls.out
