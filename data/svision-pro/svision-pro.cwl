cwlVersion: v1.2
class: CommandLineTool
baseCommand: svision-pro
label: svision-pro
doc: "SVision-PRO: A deep learning-based structural variant caller.\n\nTool homepage:
  https://github.com/songbowang125/SVision-pro"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svision-pro:2.5--pyhdfd78af_0
stdout: svision-pro.out
