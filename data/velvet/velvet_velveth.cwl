cwlVersion: v1.2
class: CommandLineTool
baseCommand: velveth
label: velvet_velveth
doc: "The provided text does not contain help information or usage instructions for
  velvet_velveth; it appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  failing to fetch the tool image.\n\nTool homepage: https://github.com/dzerbino/velvet"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/velvet:1.2.10--h7132678_5
stdout: velvet_velveth.out
