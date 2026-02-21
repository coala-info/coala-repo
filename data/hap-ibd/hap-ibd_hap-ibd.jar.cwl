cwlVersion: v1.2
class: CommandLineTool
baseCommand: hap-ibd
label: hap-ibd_hap-ibd.jar
doc: "The provided text contains a fatal error message from a container runtime (Apptainer/Singularity)
  indicating a failure to build the image due to lack of disk space. It does not contain
  the help text or usage information for the hap-ibd tool.\n\nTool homepage: https://github.com/browning-lab/hap-ibd"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hap-ibd:1.0.rev20May22.818--hdfd78af_0
stdout: hap-ibd_hap-ibd.jar.out
