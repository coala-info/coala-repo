cwlVersion: v1.2
class: CommandLineTool
baseCommand: pymethylation_utils
label: pymethylation_utils
doc: "The provided text does not contain help information for the tool; it is a log
  of a failed container build process.\n\nTool homepage: https://github.com/SebastianDall/pymethylation_utils"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pymethylation_utils:0.5.3--pyh7e72e81_0
stdout: pymethylation_utils.out
