cwlVersion: v1.2
class: CommandLineTool
baseCommand: hydra-multi_extract_discordants.py
label: hydra-multi_extract_discordants.py
doc: "A tool to extract discordant read pairs for Hydra-Multi structural variant analysis.
  (Note: The provided text is a container runtime error message and does not contain
  usage or argument information).\n\nTool homepage: https://github.com/arq5x/Hydra"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hydra-multi:0.5.4--py27h5ca1c30_4
stdout: hydra-multi_extract_discordants.py.out
