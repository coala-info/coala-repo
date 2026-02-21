cwlVersion: v1.2
class: CommandLineTool
baseCommand: straw
label: hic-straw_straw
doc: "The provided text does not contain help information or a description of the
  tool; it contains environment logs and a fatal error message regarding a container
  build failure.\n\nTool homepage: https://github.com/aidenlab/straw"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hic-straw:1.3.1--py311hb99c5bc_6
stdout: hic-straw_straw.out
