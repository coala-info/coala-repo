cwlVersion: v1.2
class: CommandLineTool
baseCommand: mitgard_install_NCBITaxa.py
label: mitgard_install_NCBITaxa.py
doc: "Install the NCBI Taxonomy database for the Mitgard pipeline. Note: The provided
  help text contains only system error logs and does not list specific command-line
  arguments.\n\nTool homepage: https://github.com/pedronachtigall/MITGARD"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mitgard:1.1--hdfd78af_0
stdout: mitgard_install_NCBITaxa.py.out
