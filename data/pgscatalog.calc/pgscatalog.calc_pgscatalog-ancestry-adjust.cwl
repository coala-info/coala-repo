cwlVersion: v1.2
class: CommandLineTool
baseCommand: pgscatalog-ancestry-adjust
label: pgscatalog.calc_pgscatalog-ancestry-adjust
doc: "A tool for ancestry adjustment in the PGS Catalog calculation pipeline. Note:
  The provided help text contains only system error messages regarding container build
  failure ('no space left on device') and does not list specific arguments.\n\nTool
  homepage: https://github.com/PGScatalog/pygscatalog/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pgscatalog.calc:0.3.1--pyhdfd78af_1
stdout: pgscatalog.calc_pgscatalog-ancestry-adjust.out
