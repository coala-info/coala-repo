cwlVersion: v1.2
class: CommandLineTool
baseCommand: ldblockshow
label: ldblockshow
doc: "A tool for Linkage Disequilibrium (LD) block visualization. (Note: The provided
  text contains system error messages regarding container execution and does not include
  the actual help documentation for the tool.)\n\nTool homepage: https://github.com/BGI-shenzhen/LDBlockShow"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ldblockshow:1.41--pl5321h077b44d_0
stdout: ldblockshow.out
