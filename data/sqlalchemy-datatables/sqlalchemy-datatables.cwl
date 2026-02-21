cwlVersion: v1.2
class: CommandLineTool
baseCommand: sqlalchemy-datatables
label: sqlalchemy-datatables
doc: "A library to provide an easy integration between SQLAlchemy and DataTables (Note:
  The provided text is an error log and does not contain CLI help information).\n\n
  Tool homepage: https://github.com/pegase745/sqlalchemy-datatables"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sqlalchemy-datatables:2.0.1--py_0
stdout: sqlalchemy-datatables.out
