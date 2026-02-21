cwlVersion: v1.2
class: CommandLineTool
baseCommand: viramp-hub
label: viramp-hub
doc: "The provided text does not contain help information or a description of the
  tool; it appears to be a log of a failed container build process.\n\nTool homepage:
  https://github.com/wm75/viramp-hub"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viramp-hub:0.1.0--pyhdfd78af_0
stdout: viramp-hub.out
