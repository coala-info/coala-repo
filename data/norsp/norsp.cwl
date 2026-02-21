cwlVersion: v1.2
class: CommandLineTool
baseCommand: norsp
label: norsp
doc: "NOn-Regular Secondary Structure Predictor. (Note: The provided text contains
  container runtime errors and does not include usage instructions or argument definitions).\n
  \nTool homepage: https://github.com/vansencool/NorsPaper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/norsp:v1.0.6-4-deb_cv1
stdout: norsp.out
