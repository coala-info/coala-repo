cwlVersion: v1.2
class: CommandLineTool
baseCommand: liqa
label: liqa
doc: "Long-read Isoform Quantification and Analysis (Note: The provided text is a
  system error log regarding a container build failure and does not contain CLI help
  information).\n\nTool homepage: https://github.com/WGLab/LIQA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/liqa:1.3.4--pyhdfd78af_0
stdout: liqa.out
