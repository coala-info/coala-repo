cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dashing
  - view
label: dashing_view
doc: "Emit register values for HLLs for human readability. Usage: dashing view f1.hll\
  \ [f2.hll ...]. Only HLLs currently supported.\n\nTool homepage: https://github.com/dnbaker/dashing"
inputs:
  - id: sketches
    type:
      type: array
      items: File
    doc: HLL sketch files
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dashing:1.0--h5b0a936_3
stdout: dashing_view.out
