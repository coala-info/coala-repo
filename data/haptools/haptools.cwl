cwlVersion: v1.2
class: CommandLineTool
baseCommand: haptools
label: haptools
doc: "Haptools is a tool for ancestry and haplotype manipulation, however, the provided
  text contains only system error messages and no help documentation to parse.\n\n
  Tool homepage: https://github.com/cast-genomics/haptools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haptools:0.6.2--pyhdfd78af_0
stdout: haptools.out
