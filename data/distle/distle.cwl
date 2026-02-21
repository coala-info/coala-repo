cwlVersion: v1.2
class: CommandLineTool
baseCommand: distle
label: distle
doc: "The provided text does not contain help information or a description of the
  tool; it contains error logs related to a container runtime failure.\n\nTool homepage:
  https://github.com/KHajji/distle"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/distle:0.3.0--hc1c3326_0
stdout: distle.out
