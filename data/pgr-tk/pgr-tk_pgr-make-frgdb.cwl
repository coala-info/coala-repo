cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pgr-tk
  - pgr-make-frgdb
label: pgr-tk_pgr-make-frgdb
doc: "The provided text is an error log from a container build process and does not
  contain help information or argument definitions for the tool.\n\nTool homepage:
  https://github.com/Sema4-Research/pgr-tk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pgr-tk:0.5.1--py38hfa1e82d_1
stdout: pgr-tk_pgr-make-frgdb.out
