cwlVersion: v1.2
class: CommandLineTool
baseCommand: quick-variants
label: quick-variants
doc: "The provided text appears to be a container execution error log rather than
  help text. No usage information or arguments could be extracted.\n\nTool homepage:
  https://github.com/caozhichongchong/QuickVariants"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/quick-variants:1.2.4--hdfd78af_0
stdout: quick-variants.out
