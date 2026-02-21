cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - parascopy
  - homologous
label: parascopy_homologous
doc: "The provided help text indicates that 'homologous' is an unknown command for
  the 'parascopy' tool. Valid commands include help, version, cite, pretable, table,
  depth, cn, cn-using, pool, view, msa, psvs, examine, and call.\n\nTool homepage:
  https://github.com/tprodanov/parascopy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/parascopy:1.19.0--py312hc576ae5_0
stdout: parascopy_homologous.out
