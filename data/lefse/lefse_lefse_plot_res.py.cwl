cwlVersion: v1.2
class: CommandLineTool
baseCommand: lefse_plot_res.py
label: lefse_lefse_plot_res.py
doc: "The provided text does not contain help information for the tool; it contains
  system error messages related to a container runtime (Singularity/Apptainer) failure
  due to insufficient disk space.\n\nTool homepage: https://github.com/SegataLab/lefse"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lefse:1.1.2--pyhdfd78af_0
stdout: lefse_lefse_plot_res.py.out
