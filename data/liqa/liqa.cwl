cwlVersion: v1.2
class: CommandLineTool
baseCommand: liqa
label: liqa
doc: "Please specify task\n\nTool homepage: https://github.com/WGLab/LIQA"
inputs:
  - id: task
    type: string
    doc: task to perform
    inputBinding:
      position: 101
      prefix: --task
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/liqa:1.3.4--pyhdfd78af_0
stdout: liqa.out
