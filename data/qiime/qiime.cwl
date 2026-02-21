cwlVersion: v1.2
class: CommandLineTool
baseCommand: qiime
label: qiime
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a log of a failed container build process.\n\nTool homepage:
  https://github.com/YongxinLiu/QIIME2ChineseManual"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/qiime:1.9.1--py27_0
stdout: qiime.out
