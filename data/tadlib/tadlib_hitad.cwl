cwlVersion: v1.2
class: CommandLineTool
baseCommand: tadlib_hitad
label: tadlib_hitad
doc: "A tool for identifying hierarchical Topologically Associating Domains (TADs).
  Note: The provided text contains container execution logs and a fatal error rather
  than the standard help documentation.\n\nTool homepage: https://github.com/XiaoTaoWang/TADLib/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tadlib:0.4.5.post1--pyhdfd78af_1
stdout: tadlib_hitad.out
