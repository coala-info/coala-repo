cwlVersion: v1.2
class: CommandLineTool
baseCommand: ShowLDSVG
label: ldblockshow_ShowLDSVG
doc: "The provided text does not contain help information for the tool. It contains
  system log messages and a fatal error regarding container image creation (no space
  left on device).\n\nTool homepage: https://github.com/BGI-shenzhen/LDBlockShow"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ldblockshow:1.41--pl5321h077b44d_0
stdout: ldblockshow_ShowLDSVG.out
