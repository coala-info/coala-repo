cwlVersion: v1.2
class: CommandLineTool
baseCommand: DeepMAsED-SM
label: deepmased_DeepMAsED-SM
doc: "Deep learning for Metagenomic Assembly Error Detection (Note: The provided help
  text contains only system error messages and no usage information).\n\nTool homepage:
  https://github.com/leylabmpi/DeepMAsED"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepmased:0.3.1--pyh5ca1d4c_0
stdout: deepmased_DeepMAsED-SM.out
