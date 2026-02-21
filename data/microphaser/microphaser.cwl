cwlVersion: v1.2
class: CommandLineTool
baseCommand: microphaser
label: microphaser
doc: "A tool for identifying phased variants from sequencing data. (Note: The provided
  help text contains only system error messages and no usage information.)\n\nTool
  homepage: https://github.com/koesterlab/microphaser"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/microphaser:0.8.0--hdc3fcad_2
stdout: microphaser.out
