cwlVersion: v1.2
class: CommandLineTool
baseCommand: cstag
label: cstag-cli_cstag
doc: "A tool for manipulating and generating CS tags (Compressed Suffix tags) for
  SAM/BAM files.\n\nTool homepage: https://github.com/akikuno/cstag-cli"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cstag-cli:1.0.0--pyhdfd78af_1
stdout: cstag-cli_cstag.out
