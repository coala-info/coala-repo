cwlVersion: v1.2
class: CommandLineTool
baseCommand: predictprotein
label: predictprotein
doc: "PredictProtein is a service for sequence analysis, structure, and function prediction.\n\
  \nTool homepage: https://github.com/Rostlab/predictprotein-docker"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/predictprotein:v1.1.07-2-deb_cv1
stdout: predictprotein.out
