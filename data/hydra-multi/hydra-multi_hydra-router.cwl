cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hydra-multi
  - hydra-router
label: hydra-multi_hydra-router
doc: "The provided text is an error log regarding a container build failure (no space
  left on device) and does not contain help documentation or argument definitions
  for the tool.\n\nTool homepage: https://github.com/arq5x/Hydra"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hydra-multi:0.5.4--py27h5ca1c30_4
stdout: hydra-multi_hydra-router.out
