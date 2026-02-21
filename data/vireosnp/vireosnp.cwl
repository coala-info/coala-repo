cwlVersion: v1.2
class: CommandLineTool
baseCommand: vireosnp
label: vireosnp
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  failing to fetch or build the image.\n\nTool homepage: https://github.com/huangyh09/vireoSNP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vireosnp:0.5.9--pyh7e72e81_0
stdout: vireosnp.out
