cwlVersion: v1.2
class: CommandLineTool
baseCommand: arriba_download_references.sh
label: arriba_download_references.sh
doc: "A script to download reference files for the Arriba fusion detection tool.\n
  \nTool homepage: https://github.com/suhrig/arriba"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/arriba:2.5.1--h87b9561_0
stdout: arriba_download_references.sh.out
