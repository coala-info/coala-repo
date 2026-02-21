cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - parascopy
  - between
label: parascopy_between
doc: "Error: unknown command \"between\". Valid commands: help, version, cite, pretable,
  table, depth, cn, cn-using, pool, view, msa, psvs, examine, call.\n\nTool homepage:
  https://github.com/tprodanov/parascopy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/parascopy:1.19.0--py312hc576ae5_0
stdout: parascopy_between.out
