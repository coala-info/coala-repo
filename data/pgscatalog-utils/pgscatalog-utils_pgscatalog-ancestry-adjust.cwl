cwlVersion: v1.2
class: CommandLineTool
baseCommand: pgscatalog-ancestry-adjust
label: pgscatalog-utils_pgscatalog-ancestry-adjust
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a system error log indicating a failure to build or extract a container
  image due to insufficient disk space ('no space left on device').\n\nTool homepage:
  https://github.com/PGScatalog/pygscatalog"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pgscatalog-utils:2.0.2--pyhdfd78af_0
stdout: pgscatalog-utils_pgscatalog-ancestry-adjust.out
