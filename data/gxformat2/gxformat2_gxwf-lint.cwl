cwlVersion: v1.2
class: CommandLineTool
baseCommand: gxwf-lint
label: gxformat2_gxwf-lint
doc: "A tool for linting Galaxy workflows (Format 2).\n\nTool homepage: https://github.com/jmchilton/gxformat2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gxformat2:0.21.0--pyhdfd78af_0
stdout: gxformat2_gxwf-lint.out
