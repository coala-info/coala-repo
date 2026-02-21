cwlVersion: v1.2
class: CommandLineTool
baseCommand: hydra-multi_make_hydra_config.py
label: hydra-multi_make_hydra_config.py
doc: "The provided text does not contain help information for the tool; it contains
  system logs and a fatal error regarding disk space during a container build process.\n
  \nTool homepage: https://github.com/arq5x/Hydra"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hydra-multi:0.5.4--py27h5ca1c30_4
stdout: hydra-multi_make_hydra_config.py.out
