cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pgscatalog-matchmerge
label: pgscatalog.match_pgscatalog-matchmerge
doc: "The provided text does not contain help documentation for the tool, but rather
  a system error log indicating a failure to build or run a container due to lack
  of disk space ('no space left on device').\n\nTool homepage: https://github.com/PGScatalog/pygscatalog"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pgscatalog.match:0.4.0--pyhdfd78af_0
stdout: pgscatalog.match_pgscatalog-matchmerge.out
