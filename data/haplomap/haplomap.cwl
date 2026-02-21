cwlVersion: v1.2
class: CommandLineTool
baseCommand: haplomap
label: haplomap
doc: "A tool for haplotype mapping (Note: The provided help text contains only system
  error messages and no usage information).\n\nTool homepage: https://github.com/zqfang/haplomap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haplomap:0.1.2--h4656aac_1
stdout: haplomap.out
