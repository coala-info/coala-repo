cwlVersion: v1.2
class: CommandLineTool
baseCommand: pgscatalog.match
label: pgscatalog.match
doc: "The provided text does not contain help information or usage instructions for
  pgscatalog.match. It contains system logs and a fatal error message regarding a
  failed container build due to insufficient disk space.\n\nTool homepage: https://github.com/PGScatalog/pygscatalog"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pgscatalog.match:0.4.0--pyhdfd78af_0
stdout: pgscatalog.match.out
