cwlVersion: v1.2
class: CommandLineTool
baseCommand: feedgnuplot
label: gnuplot_feedgnuplot
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be an error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build a SIF image due to lack of disk space.\n\nTool homepage:
  https://github.com/dkogan/feedgnuplot"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gnuplot:5.2.3
stdout: gnuplot_feedgnuplot.out
