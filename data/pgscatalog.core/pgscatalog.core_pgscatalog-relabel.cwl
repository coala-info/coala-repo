cwlVersion: v1.2
class: CommandLineTool
baseCommand: pgscatalog-relabel
label: pgscatalog.core_pgscatalog-relabel
doc: "A tool from the pgscatalog.core suite (description not available in the provided
  text).\n\nTool homepage: https://github.com/PGScatalog/pygscatalog/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pgscatalog.core:1.0.2--pyhdfd78af_0
stdout: pgscatalog.core_pgscatalog-relabel.out
