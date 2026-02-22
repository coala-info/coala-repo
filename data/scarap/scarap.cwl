cwlVersion: v1.2
class: CommandLineTool
baseCommand: scarap
label: scarap
doc: "The provided text contains system error messages related to a container runtime
  (Singularity/Apptainer) failing to pull the scarap image due to lack of disk space,
  rather than the tool's help documentation. Consequently, no arguments or functional
  descriptions could be extracted.\n\nTool homepage: https://pypi.org/project/scarap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scarap:1.0.1--pyhdfd78af_0
stdout: scarap.out
