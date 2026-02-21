cwlVersion: v1.2
class: CommandLineTool
baseCommand: hydra-multi_assemble-routed-files.sh
label: hydra-multi_assemble-routed-files.sh
doc: "A script for assembling routed files within the hydra-multi pipeline. (Note:
  The provided text appears to be a container runtime error log rather than help documentation,
  so no arguments could be extracted.)\n\nTool homepage: https://github.com/arq5x/Hydra"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hydra-multi:0.5.4--py27h5ca1c30_4
stdout: hydra-multi_assemble-routed-files.sh.out
