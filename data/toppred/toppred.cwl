cwlVersion: v1.2
class: CommandLineTool
baseCommand: toppred
label: toppred
doc: "Topology prediction of membrane proteins. (Note: The provided text contains
  container runtime errors and does not list specific command-line arguments or usage
  instructions).\n\nTool homepage: https://github.com/C3BI-pasteur-fr/toppred"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/toppred:v1.10-7-deb_cv1
stdout: toppred.out
