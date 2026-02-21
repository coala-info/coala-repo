cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fraposa-pgsc
  - fraposa_plot
label: fraposa-pgsc_fraposa_plot
doc: "The provided text does not contain help information for the tool. It contains
  container runtime error logs (Apptainer/Singularity) indicating a failure to build
  the SIF image due to lack of disk space.\n\nTool homepage: https://github.com/PGScatalog/fraposa_pgsc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fraposa-pgsc:1.0.2--pyhdfd78af_0
stdout: fraposa-pgsc_fraposa_plot.out
