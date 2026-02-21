cwlVersion: v1.2
class: CommandLineTool
baseCommand: mummer2circos
label: mummer2circos
doc: "A tool to convert MUMmer alignment output to Circos format. Note: The provided
  help text contains only system error messages and no usage information.\n\nTool
  homepage: https://github.com/metagenlab/mummer2circos"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mummer2circos:1.4.2--pyhdfd78af_0
stdout: mummer2circos.out
