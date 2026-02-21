cwlVersion: v1.2
class: CommandLineTool
baseCommand: demuxlet
label: demuxlet
doc: "The provided text does not contain help information or a description of the
  tool; it contains system error messages related to a container runtime failure (no
  space left on device).\n\nTool homepage: https://github.com/statgen/demuxlet"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/demuxlet:1.0--h5ca1c30_7
stdout: demuxlet.out
