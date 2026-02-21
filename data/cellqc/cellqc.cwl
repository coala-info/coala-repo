cwlVersion: v1.2
class: CommandLineTool
baseCommand: cellqc
label: cellqc
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain the help documentation or usage instructions for the cellqc
  tool. As a result, no arguments could be extracted.\n\nTool homepage: https://github.com/lijinbio/cellqc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cellqc:0.1.0--pyh7e72e81_0
stdout: cellqc.out
