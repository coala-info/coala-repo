cwlVersion: v1.2
class: CommandLineTool
baseCommand: pgscatalog.core
label: pgscatalog.core
doc: "The provided text does not contain help information or a description of the
  tool; it is a log of a failed container build process due to insufficient disk space.\n
  \nTool homepage: https://github.com/PGScatalog/pygscatalog/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pgscatalog.core:1.0.2--pyhdfd78af_0
stdout: pgscatalog.core.out
