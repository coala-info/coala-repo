cwlVersion: v1.2
class: CommandLineTool
baseCommand: parascopy
label: parascopy_and
doc: "A tool for analyzing paralogous sequence copies. Valid commands include help,
  version, cite, pretable, table, depth, cn, cn-using, pool, view, msa, psvs, examine,
  call.\n\nTool homepage: https://github.com/tprodanov/parascopy"
inputs:
  - id: command
    type: string
    doc: The command to execute (e.g., help, version, cite, pretable, table, depth,
      cn, cn-using, pool, view, msa, psvs, examine, call)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/parascopy:1.19.0--py312hc576ae5_0
stdout: parascopy_and.out
