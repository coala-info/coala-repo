cwlVersion: v1.2
class: CommandLineTool
baseCommand: hap-ibd
label: hap-ibd
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  to build an image due to lack of disk space.\n\nTool homepage: https://github.com/browning-lab/hap-ibd"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hap-ibd:1.0.rev20May22.818--hdfd78af_0
stdout: hap-ibd.out
