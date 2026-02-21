cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pgscatalog-utils
  - validate
label: pgscatalog-utils_pgscatalog-validate
doc: "A tool to validate PGS Catalog files. (Note: The provided help text contains
  container execution errors rather than command usage; no arguments could be extracted
  from the input text.)\n\nTool homepage: https://github.com/PGScatalog/pygscatalog"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pgscatalog-utils:2.0.2--pyhdfd78af_0
stdout: pgscatalog-utils_pgscatalog-validate.out
