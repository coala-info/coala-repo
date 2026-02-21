cwlVersion: v1.2
class: CommandLineTool
baseCommand: cstag
label: cstag_cstag-cli
doc: "A tool for generating or manipulating CS (Canonical Sequence) tags in SAM/BAM
  files.\n\nTool homepage: https://github.com/akikuno/cstag"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cstag:1.1.0--pyhdfd78af_1
stdout: cstag_cstag-cli.out
