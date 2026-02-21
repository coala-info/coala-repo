cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pgscatalog.calc
  - pgscatalog-aggregate
label: pgscatalog.calc_pgscatalog-aggregate
doc: "The provided text does not contain help information or a description of the
  tool. It contains system logs and a fatal error message regarding a container build
  failure (no space left on device).\n\nTool homepage: https://github.com/PGScatalog/pygscatalog/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pgscatalog.calc:0.3.1--pyhdfd78af_1
stdout: pgscatalog.calc_pgscatalog-aggregate.out
