cwlVersion: v1.2
class: CommandLineTool
baseCommand: igda-script_getbambyregion
label: igda-script_getbambyregion
doc: "The provided text does not contain help information for the tool, but appears
  to be a system error log regarding container image conversion and disk space issues.\n
  \nTool homepage: https://github.com/zhixingfeng/shell"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igda-script:1.0.1--hdfd78af_0
stdout: igda-script_getbambyregion.out
