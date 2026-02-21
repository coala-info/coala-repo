cwlVersion: v1.2
class: CommandLineTool
baseCommand: rnasketch_design-ligandswitch.py
label: rnasketch_design-ligandswitch.py
doc: "A tool for designing ligand-switch RNA (Note: The provided help text contains
  only container runtime logs and an error message, so specific arguments could not
  be extracted).\n\nTool homepage: https://github.com/ViennaRNA/RNAsketch"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnasketch:1.5--py27_1
stdout: rnasketch_design-ligandswitch.py.out
