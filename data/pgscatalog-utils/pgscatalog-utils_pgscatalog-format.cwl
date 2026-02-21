cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pgscatalog-utils
  - pgscatalog-format
label: pgscatalog-utils_pgscatalog-format
doc: "The provided text is an error log from a container build process and does not
  contain help documentation for the tool. No arguments could be extracted.\n\nTool
  homepage: https://github.com/PGScatalog/pygscatalog"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pgscatalog-utils:2.0.2--pyhdfd78af_0
stdout: pgscatalog-utils_pgscatalog-format.out
