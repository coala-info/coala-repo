cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pgscatalog-utils
  - pgscatalog-intersect
label: pgscatalog-utils_pgscatalog-intersect
doc: "The provided text does not contain help information for the tool. It contains
  error logs related to a container build failure (no space left on device).\n\nTool
  homepage: https://github.com/PGScatalog/pygscatalog"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pgscatalog-utils:2.0.2--pyhdfd78af_0
stdout: pgscatalog-utils_pgscatalog-intersect.out
