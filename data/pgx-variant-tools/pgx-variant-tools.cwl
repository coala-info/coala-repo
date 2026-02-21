cwlVersion: v1.2
class: CommandLineTool
baseCommand: pgx-variant-tools
label: pgx-variant-tools
doc: "A tool for pharmacogenomics (PGx) variant analysis. Note: The provided text
  appears to be a system error log regarding a container build failure ('no space
  left on device') rather than the tool's help documentation. Consequently, no arguments
  could be extracted.\n\nTool homepage: https://github.com/LUMC/pgx-variant-tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pgx-variant-tools:0.0.5--py_0
stdout: pgx-variant-tools.out
