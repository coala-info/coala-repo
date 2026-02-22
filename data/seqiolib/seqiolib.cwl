cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqiolib
label: seqiolib
doc: "The provided text does not contain help information or usage instructions for
  the tool. It consists of system error messages related to a container runtime (Singularity/Apptainer)
  failing to pull an image due to insufficient disk space.\n\nTool homepage: https://github.com/visze/seqiolib"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqiolib:0.2.4--pyhdfd78af_0
stdout: seqiolib.out
