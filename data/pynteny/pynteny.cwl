cwlVersion: v1.2
class: CommandLineTool
baseCommand: pynteny
label: pynteny
doc: "The provided text does not contain help information or a description of the
  tool; it is a log of a failed container build process.\n\nTool homepage: http://github.com/robaina/Pynteny"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pynteny:1.0.0--py310hec16e2b_0
stdout: pynteny.out
