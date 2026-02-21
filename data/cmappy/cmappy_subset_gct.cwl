cwlVersion: v1.2
class: CommandLineTool
baseCommand: cmappy_subset_gct
label: cmappy_subset_gct
doc: "A tool to subset GCT files (Note: The provided help text contains only container
  execution errors and no usage information).\n\nTool homepage: https://github.com/cmap/cmapPy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cmappy:4.0.1--py39h2de1943_8
stdout: cmappy_subset_gct.out
