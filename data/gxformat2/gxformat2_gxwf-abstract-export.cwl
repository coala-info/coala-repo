cwlVersion: v1.2
class: CommandLineTool
baseCommand: gxwf-abstract-export
label: gxformat2_gxwf-abstract-export
doc: "Export abstract Galaxy workflows (Note: The provided help text contains only
  system error messages and no usage information).\n\nTool homepage: https://github.com/jmchilton/gxformat2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gxformat2:0.21.0--pyhdfd78af_0
stdout: gxformat2_gxwf-abstract-export.out
