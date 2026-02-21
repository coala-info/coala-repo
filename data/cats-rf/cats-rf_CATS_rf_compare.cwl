cwlVersion: v1.2
class: CommandLineTool
baseCommand: CATS_rf_compare
label: cats-rf_CATS_rf_compare
doc: "A tool from the cats-rf suite (Note: The provided help text contains only container
  build error logs and no usage information).\n\nTool homepage: https://github.com/bodulic/CATS-rf"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cats-rf:1.0.4--hdfd78af_0
stdout: cats-rf_CATS_rf_compare.out
