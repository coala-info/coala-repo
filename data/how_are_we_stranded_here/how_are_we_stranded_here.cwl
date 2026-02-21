cwlVersion: v1.2
class: CommandLineTool
baseCommand: how_are_we_stranded_here
label: how_are_we_stranded_here
doc: "The provided text does not contain help information or documentation for the
  tool; it contains system log messages and a fatal error regarding disk space during
  a container build.\n\nTool homepage: https://github.com/betsig/how_are_we_stranded_here"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/how_are_we_stranded_here:1.0.1--pyhfa5458b_0
stdout: how_are_we_stranded_here.out
