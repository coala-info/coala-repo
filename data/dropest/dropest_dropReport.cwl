cwlVersion: v1.2
class: CommandLineTool
baseCommand: dropest_dropReport
label: dropest_dropReport
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  to build an image due to insufficient disk space.\n\nTool homepage: https://github.com/hms-dbmi/dropEst/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dropest:0.8.6--r36hf6b077f_0
stdout: dropest_dropReport.out
