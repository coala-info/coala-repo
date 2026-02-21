cwlVersion: v1.2
class: CommandLineTool
baseCommand: mlpy
label: metabolabpy_mlpy
doc: "MetaboLab Python package. (Note: The provided text is a container runtime error
  log and does not contain command-line help information or argument definitions.)\n
  \nTool homepage: https://github.com/ludwigc/metabolabpy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metabolabpy:0.9.85--pyhdfd78af_0
stdout: metabolabpy_mlpy.out
