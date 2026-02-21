cwlVersion: v1.2
class: CommandLineTool
baseCommand: pgscatalog-match
label: pgscatalog.match_pgscatalog-match
doc: "The provided text is an error log indicating a failure to build or pull the
  container image due to insufficient disk space ('no space left on device'). It does
  not contain the help text or usage information for the tool. As a result, no arguments
  could be extracted.\n\nTool homepage: https://github.com/PGScatalog/pygscatalog"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pgscatalog.match:0.4.0--pyhdfd78af_0
stdout: pgscatalog.match_pgscatalog-match.out
