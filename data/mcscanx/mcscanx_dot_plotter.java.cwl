cwlVersion: v1.2
class: CommandLineTool
baseCommand: mcscanx_dot_plotter.java
label: mcscanx_dot_plotter.java
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Singularity/Apptainer) failing
  to build an image due to lack of disk space.\n\nTool homepage: https://github.com/wyp1125/MCScanX"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mcscanx:1.0.0--h9948957_0
stdout: mcscanx_dot_plotter.java.out
