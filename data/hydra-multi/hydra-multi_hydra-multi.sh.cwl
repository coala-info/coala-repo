cwlVersion: v1.2
class: CommandLineTool
baseCommand: hydra-multi_hydra-multi.sh
label: hydra-multi_hydra-multi.sh
doc: "Hydra-multi structural variant caller. (Note: The provided text is a system
  error log indicating a failure to build the container image due to lack of disk
  space and does not contain usage instructions or argument definitions.)\n\nTool
  homepage: https://github.com/arq5x/Hydra"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hydra-multi:0.5.4--py27h5ca1c30_4
stdout: hydra-multi_hydra-multi.sh.out
