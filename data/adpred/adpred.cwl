cwlVersion: v1.2
class: CommandLineTool
baseCommand: adpred
label: adpred
doc: "The provided text does not contain help information for the tool 'adpred'. It
  contains error logs from a container runtime (Apptainer/Singularity) indicating
  a failure to build the image due to lack of disk space.\n\nTool homepage: https://github.com/FredHutch/adpred"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/adpred:1.3.1--pyhdfd78af_0
stdout: adpred.out
