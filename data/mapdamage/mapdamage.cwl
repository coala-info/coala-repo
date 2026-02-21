cwlVersion: v1.2
class: CommandLineTool
baseCommand: mapDamage
label: mapdamage
doc: "mapDamage is a tool for tracking and quantifying DNA damage patterns in ancient
  DNA sequences. (Note: The provided help text contains only system error messages
  regarding container execution and does not list command-line arguments.)\n\nTool
  homepage: https://github.com/ginolhac/mapDamage"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/mapdamage:v2.0.6dfsg-2-deb_cv1
stdout: mapdamage.out
