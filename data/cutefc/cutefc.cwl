cwlVersion: v1.2
class: CommandLineTool
baseCommand: cutefc
label: cutefc
doc: "The provided text does not contain help information or usage instructions for
  the tool 'cutefc'. It appears to be an error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build or extract a container image due to insufficient disk
  space.\n\nTool homepage: https://github.com/tjiangHIT/cuteFC"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cutefc:1.0.2--pyhdfd78af_0
stdout: cutefc.out
