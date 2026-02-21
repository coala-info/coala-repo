cwlVersion: v1.2
class: CommandLineTool
baseCommand: mlst-cge_install_update_pack.py
label: mlst-cge_install_update_pack.py
doc: "Install or update packs for MLST-CGE. Note: The provided input text appears
  to be a container runtime error log rather than help text, so no arguments could
  be extracted.\n\nTool homepage: https://bitbucket.org/genomicepidemiology/mlst"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mlst-cge:2.0.9--hdfd78af_0
stdout: mlst-cge_install_update_pack.py.out
