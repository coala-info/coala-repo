cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pgscatalog-download
label: pgscatalog-utils_pgscatalog-download
doc: "Download data from the PGS Catalog. (Note: The provided input text contains
  system error messages regarding container extraction and does not include the tool's
  help documentation or argument definitions.)\n\nTool homepage: https://github.com/PGScatalog/pygscatalog"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pgscatalog-utils:2.0.2--pyhdfd78af_0
stdout: pgscatalog-utils_pgscatalog-download.out
