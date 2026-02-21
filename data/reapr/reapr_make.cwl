cwlVersion: v1.2
class: CommandLineTool
baseCommand: reapr_make
label: reapr_make
doc: "The provided text does not contain help information or a description of the
  tool; it contains system logs and a fatal error related to a container build failure.\n
  \nTool homepage: https://github.com/tadelv/reaprime"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/reapr:v1.0.18dfsg-4-deb_cv1
stdout: reapr_make.out
