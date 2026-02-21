cwlVersion: v1.2
class: CommandLineTool
baseCommand: ctseq
label: ctseq
doc: "The provided text does not contain help information or a description of the
  tool's functionality; it is an error log from a container runtime (Apptainer/Singularity)
  indicating a failure to extract the image due to lack of disk space.\n\nTool homepage:
  https://github.com/ryanhmiller/ctseq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ctseq:0.0.2--py_0
stdout: ctseq.out
