cwlVersion: v1.2
class: CommandLineTool
baseCommand: visor
label: visor
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be a log of a failed container build process.\n\nTool homepage:
  https://github.com/davidebolo1993/VISOR.git"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/visor:1.1.2.1--pyh7cba7a3_0
stdout: visor.out
