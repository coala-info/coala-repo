cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pgscatalog-match
label: pgscatalog-utils_pgscatalog-match
doc: "The provided text is a system error log (out of disk space during container
  build) and does not contain CLI help information or argument definitions.\n\nTool
  homepage: https://github.com/PGScatalog/pygscatalog"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pgscatalog-utils:2.0.2--pyhdfd78af_0
stdout: pgscatalog-utils_pgscatalog-match.out
