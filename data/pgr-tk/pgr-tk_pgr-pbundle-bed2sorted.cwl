cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pgr-pbundle-bed2sorted
label: pgr-tk_pgr-pbundle-bed2sorted
doc: "The provided help text contains only system error messages related to a container
  build failure and does not include usage information or argument descriptions.\n
  \nTool homepage: https://github.com/Sema4-Research/pgr-tk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pgr-tk:0.5.1--py38hfa1e82d_1
stdout: pgr-tk_pgr-pbundle-bed2sorted.out
