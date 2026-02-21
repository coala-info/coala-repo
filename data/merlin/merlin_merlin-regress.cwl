cwlVersion: v1.2
class: CommandLineTool
baseCommand: merlin-regress
label: merlin_merlin-regress
doc: "A tool for regression analysis (Note: The provided help text contains only system
  error messages and no usage information).\n\nTool homepage: http://csg.sph.umich.edu/abecasis/merlin"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/merlin:1.1.2--h077b44d_8
stdout: merlin_merlin-regress.out
