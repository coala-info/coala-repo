cwlVersion: v1.2
class: CommandLineTool
baseCommand: epic2-df
label: epic2_epic2-df
doc: "The provided text does not contain help information for the tool. It contains
  system log messages and a fatal error regarding disk space during a container build
  process.\n\nTool homepage: http://github.com/endrebak/epic2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/epic2:0.0.54--py310h5140242_0
stdout: epic2_epic2-df.out
