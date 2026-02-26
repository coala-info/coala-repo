cwlVersion: v1.2
class: CommandLineTool
baseCommand: dashing
label: dashing_Produces
doc: "Dashing version: v1.0\n\nTool homepage: https://github.com/dnbaker/dashing"
inputs:
  - id: subcommand
    type: string
    doc: Subcommand to run (e.g., sketch, sketch_by_seq, cmp, union, view, 
      printmat, fold)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dashing:1.0--h5b0a936_3
stdout: dashing_Produces.out
