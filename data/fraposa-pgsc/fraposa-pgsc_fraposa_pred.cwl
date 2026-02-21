cwlVersion: v1.2
class: CommandLineTool
baseCommand: fraposa_pred
label: fraposa-pgsc_fraposa_pred
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log indicating a failure to build a Singularity/Apptainer container
  due to insufficient disk space.\n\nTool homepage: https://github.com/PGScatalog/fraposa_pgsc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fraposa-pgsc:1.0.2--pyhdfd78af_0
stdout: fraposa-pgsc_fraposa_pred.out
