cwlVersion: v1.2
class: CommandLineTool
baseCommand: pgscatalog-format
label: pgscatalog.core_pgscatalog-format
doc: "A tool from the pgscatalog.core suite, likely used for formatting PGS Catalog
  data. (Note: The provided text contains system error logs rather than help documentation,
  so specific arguments could not be extracted.)\n\nTool homepage: https://github.com/PGScatalog/pygscatalog/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pgscatalog.core:1.0.2--pyhdfd78af_0
stdout: pgscatalog.core_pgscatalog-format.out
