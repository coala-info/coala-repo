cwlVersion: v1.2
class: CommandLineTool
baseCommand: kid
label: kid
doc: "The provided text is an error message from a container runtime (Apptainer/Singularity)
  and does not contain the help documentation or usage instructions for the 'kid'
  tool.\n\nTool homepage: https://github.com/zhihu/kids"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kid:0.9.6--py27_1
stdout: kid.out
