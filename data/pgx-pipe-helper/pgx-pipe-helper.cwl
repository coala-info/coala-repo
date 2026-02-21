cwlVersion: v1.2
class: CommandLineTool
baseCommand: pgx-pipe-helper
label: pgx-pipe-helper
doc: "A helper tool for pharmacogenomics (PGx) pipelines. Note: The provided text
  appears to be a system error log regarding a container build failure ('no space
  left on device') rather than the tool's help documentation; therefore, no arguments
  could be extracted.\n\nTool homepage: https://github.com/lumc/pgx-pipe-helper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pgx-pipe-helper:0.0.4--pyh864c0ab_1
stdout: pgx-pipe-helper.out
