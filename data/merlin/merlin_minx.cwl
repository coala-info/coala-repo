cwlVersion: v1.2
class: CommandLineTool
baseCommand: merlin_minx
label: merlin_minx
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains system log messages and a fatal error regarding container
  image conversion and disk space.\n\nTool homepage: http://csg.sph.umich.edu/abecasis/merlin"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/merlin:1.1.2--h077b44d_8
stdout: merlin_minx.out
