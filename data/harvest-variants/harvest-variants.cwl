cwlVersion: v1.2
class: CommandLineTool
baseCommand: harvest-variants
label: harvest-variants
doc: "A tool for harvesting variants (Note: The provided help text contains only container
  runtime error messages and no usage information).\n\nTool homepage: https://gitlab.com/treangenlab/sars-cov-2-harvest-variants"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/harvest-variants:1.1.0--pyhdfd78af_0
stdout: harvest-variants.out
