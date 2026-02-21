cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pgr-mdb
label: pgr-tk_pgr-mdb
doc: "The provided text is a system error log indicating a failure to build a container
  image due to insufficient disk space, rather than tool help text. No command-line
  arguments or tool descriptions could be extracted.\n\nTool homepage: https://github.com/Sema4-Research/pgr-tk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pgr-tk:0.5.1--py38hfa1e82d_1
stdout: pgr-tk_pgr-mdb.out
