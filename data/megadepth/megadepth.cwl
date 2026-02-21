cwlVersion: v1.2
class: CommandLineTool
baseCommand: megadepth
label: megadepth
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log from a container runtime failure.\n\nTool homepage: https://github.com/ChristopherWilks/megadepth"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/megadepth:1.2.0--h5ca1c30_7
stdout: megadepth.out
