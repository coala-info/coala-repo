cwlVersion: v1.2
class: CommandLineTool
baseCommand: dnoise_DnoisE.bin
label: dnoise_DnoisE.bin
doc: "The provided text does not contain help information or usage instructions. It
  is an error log from a container runtime (Apptainer/Singularity) indicating a failure
  to build the image due to lack of disk space.\n\nTool homepage: https://github.com/adriantich/DnoisE"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dnoise:1.4.2--pyhdfd78af_0
stdout: dnoise_DnoisE.bin.out
