cwlVersion: v1.2
class: CommandLineTool
baseCommand: msi_msi_install.sh
label: msi_msi_install.sh
doc: "A script to install or run the MSI (Microsatellite Instability) tool via a containerized
  environment. Note: The provided text contains execution logs and error messages
  rather than usage instructions.\n\nTool homepage: http://github.com/nunofonseca/msi/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msi:0.3.8--hdfd78af_0
stdout: msi_msi_install.sh.out
