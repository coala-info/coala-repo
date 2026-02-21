cwlVersion: v1.2
class: CommandLineTool
baseCommand: dropest
label: dropest
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log from a container runtime (Apptainer/Singularity) indicating
  a failure to build the image due to lack of disk space.\n\nTool homepage: https://github.com/hms-dbmi/dropEst/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dropest:0.8.6--r36hf6b077f_0
stdout: dropest.out
