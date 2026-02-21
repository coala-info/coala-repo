cwlVersion: v1.2
class: CommandLineTool
baseCommand: ribotish
label: ribotish
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be an error log from a container runtime (Apptainer/Singularity)
  failing to build or fetch the ribotish image.\n\nTool homepage: https://github.com/zhpn1024/ribotish"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ribotish:0.2.8--pyhdfd78af_0
stdout: ribotish.out
