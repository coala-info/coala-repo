cwlVersion: v1.2
class: CommandLineTool
baseCommand: adpred
label: adpred_run-adpred
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains error logs related to a container environment (Apptainer/Singularity)
  failing to build an image due to lack of disk space.\n\nTool homepage: https://github.com/FredHutch/adpred"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/adpred:1.3.1--pyhdfd78af_0
stdout: adpred_run-adpred.out
