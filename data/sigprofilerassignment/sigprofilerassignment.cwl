cwlVersion: v1.2
class: CommandLineTool
baseCommand: sigprofilerassignment
label: sigprofilerassignment
doc: "SigProfilerAssignment is a tool for assigning mutational signatures to individual
  samples.\n\nTool homepage: https://github.com/AlexandrovLab/SigProfilerAssignment.git"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sigprofilerassignment:1.1.3--pyhdfd78af_0
stdout: sigprofilerassignment.out
