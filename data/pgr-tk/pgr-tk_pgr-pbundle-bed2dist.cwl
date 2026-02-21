cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pgr-tk
  - pbundle-bed2dist
label: pgr-tk_pgr-pbundle-bed2dist
doc: "The provided text does not contain help information for the tool. It is a system
  error log indicating a failure to build a Singularity/Apptainer container due to
  lack of disk space.\n\nTool homepage: https://github.com/Sema4-Research/pgr-tk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pgr-tk:0.5.1--py38hfa1e82d_1
stdout: pgr-tk_pgr-pbundle-bed2dist.out
