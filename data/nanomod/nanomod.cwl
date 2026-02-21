cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanomod
label: nanomod
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain the help documentation or usage instructions for the nanomod
  tool.\n\nTool homepage: https://github.com/WGLab/NanoMod"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanomod:0.2.2--py_0
stdout: nanomod.out
