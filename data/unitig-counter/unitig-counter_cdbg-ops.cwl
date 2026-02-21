cwlVersion: v1.2
class: CommandLineTool
baseCommand: unitig-counter
label: unitig-counter_cdbg-ops
doc: "A tool for counting unitigs (likely in the context of compressed de Bruijn graphs),
  though the provided text contains only container build logs and no specific help
  documentation.\n\nTool homepage: https://github.com/johnlees/unitig-counter"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unitig-counter:1.1.0--h5ca1c30_2
stdout: unitig-counter_cdbg-ops.out
