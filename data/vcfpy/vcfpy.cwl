cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcfpy
label: vcfpy
doc: "The provided text does not contain help information for vcfpy; it contains error
  logs from a container runtime (Apptainer/Singularity) attempting to fetch the vcfpy
  image.\n\nTool homepage: https://github.com/bihealth/vcfpy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcfpy:0.14.2--pyhdfd78af_0
stdout: vcfpy.out
