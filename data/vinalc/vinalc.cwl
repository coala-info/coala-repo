cwlVersion: v1.2
class: CommandLineTool
baseCommand: vinalc
label: vinalc
doc: "VinaLC is a parallelized version of AutoDock Vina for virtual screening. (Note:
  The provided text appears to be a container engine error log rather than help text;
  no arguments could be extracted from the input.)\n\nTool homepage: https://github.com/XiaohuaZhangLLNL/VinaLC"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vinalc:1.4.2--h01b65b2_0
stdout: vinalc.out
