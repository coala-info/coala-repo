cwlVersion: v1.2
class: CommandLineTool
baseCommand: mhcflurry-predict
label: mhcflurry_mhcflurry-predict
doc: "MHC binding affinity prediction (Note: The provided help text contains only
  system error messages and no usage information).\n\nTool homepage: https://github.com/hammerlab/mhcflurry"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mhcflurry:2.1.5--pyh7e72e81_0
stdout: mhcflurry_mhcflurry-predict.out
