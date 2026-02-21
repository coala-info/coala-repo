cwlVersion: v1.2
class: CommandLineTool
baseCommand: quantms-utils
label: quantms-utils
doc: "The provided text does not contain help information for the tool. It contains
  system logs and a fatal error message related to pulling a container image (Apptainer/Singularity).\n
  \nTool homepage: https://www.github.com/bigbio/quantms-utils"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/quantms-utils:0.0.24--pyh7e72e81_0
stdout: quantms-utils.out
