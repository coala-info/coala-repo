cwlVersion: v1.2
class: CommandLineTool
baseCommand: phigaro-setup
label: phigaro_phigaro-setup
doc: "Setup tool for Phigaro. Note: The provided text appears to be a container build
  log rather than a help menu, so no arguments could be extracted.\n\nTool homepage:
  https://phigaro.readthedocs.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phigaro:2.4.0--pyhdfd78af_0
stdout: phigaro_phigaro-setup.out
