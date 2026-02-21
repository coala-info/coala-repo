cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - parascopy
  - cite
label: parascopy_cite
doc: "Display citation information for Parascopy\n\nTool homepage: https://github.com/tprodanov/parascopy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/parascopy:1.19.0--py312hc576ae5_0
stdout: parascopy_cite.out
