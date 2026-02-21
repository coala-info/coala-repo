cwlVersion: v1.2
class: CommandLineTool
baseCommand: pgscatalog-download
label: pgscatalog.core_pgscatalog-download
doc: "A tool to download data from the PGS Catalog. (Note: The provided help text
  contains only system error logs and does not list specific arguments.)\n\nTool homepage:
  https://github.com/PGScatalog/pygscatalog/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pgscatalog.core:1.0.2--pyhdfd78af_0
stdout: pgscatalog.core_pgscatalog-download.out
