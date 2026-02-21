cwlVersion: v1.2
class: CommandLineTool
baseCommand: pglite
label: pglite
doc: "A utility for managing or running a PostgreSQL instance (inferred from references
  to initdb, pg_ctl, and psql in the error logs).\n\nTool homepage: https://github.com/electric-sql/pglite"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pglite:0.1--0
stdout: pglite.out
