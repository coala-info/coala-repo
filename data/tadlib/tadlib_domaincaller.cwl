cwlVersion: v1.2
class: CommandLineTool
baseCommand: tadlib_domaincaller
label: tadlib_domaincaller
doc: "A tool for calling Topologically Associating Domains (TADs). Note: The provided
  help text contains only system error messages and no usage information.\n\nTool
  homepage: https://github.com/XiaoTaoWang/TADLib/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tadlib:0.4.5.post1--pyhdfd78af_1
stdout: tadlib_domaincaller.out
