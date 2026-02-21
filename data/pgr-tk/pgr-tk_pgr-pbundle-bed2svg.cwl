cwlVersion: v1.2
class: CommandLineTool
baseCommand: pgr-pbundle-bed2svg
label: pgr-tk_pgr-pbundle-bed2svg
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log related to a container build failure (no space left on
  device).\n\nTool homepage: https://github.com/Sema4-Research/pgr-tk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pgr-tk:0.5.1--py38hfa1e82d_1
stdout: pgr-tk_pgr-pbundle-bed2svg.out
