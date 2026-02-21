cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gothresher
  - prep
label: gothresher_gothresher_prep
doc: "The provided text contains system error logs and does not include help documentation
  for the tool. No arguments could be extracted.\n\nTool homepage: https://github.com/FriedbergLab/GOThresher"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gothresher:1.0.29--pyh7cba7a3_0
stdout: gothresher_gothresher_prep.out
