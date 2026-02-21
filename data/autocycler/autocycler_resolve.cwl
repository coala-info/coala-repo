cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - autocycler
  - resolve
label: autocycler_resolve
doc: "resolve repeats in the the unitig graph\n\nTool homepage: https://github.com/rrwick/Autocycler"
inputs:
  - id: cluster_dir
    type: Directory
    doc: Autocycler directory (required)
    inputBinding:
      position: 101
      prefix: --cluster_dir
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/autocycler:0.5.2--h3ab6199_0
stdout: autocycler_resolve.out
