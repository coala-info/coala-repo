cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pgr-query
label: pgr-tk_pgr-query
doc: "The provided text is a system error log indicating a failure to pull or build
  the container image (no space left on device) and does not contain the help text
  for the tool.\n\nTool homepage: https://github.com/Sema4-Research/pgr-tk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pgr-tk:0.5.1--py38hfa1e82d_1
stdout: pgr-tk_pgr-query.out
