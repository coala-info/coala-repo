cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pymethylation_utils
  - epimetheus
label: pymethylation_utils_epimetheus
doc: "A tool within the pymethylation_utils suite. (Note: The provided help text contains
  container build error logs and does not list specific arguments or descriptions.)\n
  \nTool homepage: https://github.com/SebastianDall/pymethylation_utils"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pymethylation_utils:0.5.3--pyh7e72e81_0
stdout: pymethylation_utils_epimetheus.out
