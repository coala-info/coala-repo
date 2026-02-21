cwlVersion: v1.2
class: CommandLineTool
baseCommand: hydra-multi_forceOneClusterPerPairMem.py
label: hydra-multi_forceOneClusterPerPairMem.py
doc: "A script from the hydra-multi suite, likely used to force one cluster per pair
  during processing. (Note: The provided help text contains only system error messages
  regarding container execution and does not list specific arguments.)\n\nTool homepage:
  https://github.com/arq5x/Hydra"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hydra-multi:0.5.4--py27h5ca1c30_4
stdout: hydra-multi_forceOneClusterPerPairMem.py.out
