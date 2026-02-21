cwlVersion: v1.2
class: CommandLineTool
baseCommand: pytrf
label: pytrf
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a fatal error log from a container runtime (Singularity/Apptainer)
  failing to fetch or build the image.\n\nTool homepage: https://github.com/lmdu/pytrf"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pytrf:1.4.2--py310h1fe012e_1
stdout: pytrf.out
