cwlVersion: v1.2
class: CommandLineTool
baseCommand: mpboot
label: mpboot_mpboot-avx
doc: "MPBoot: fast maximum parsimony tree bootstrap. (Note: The provided text contains
  only system error messages and no help documentation; therefore, no arguments could
  be extracted.)\n\nTool homepage: https://github.com/diepthihoang/mpboot"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mpboot:1.2--h503566f_0
stdout: mpboot_mpboot-avx.out
