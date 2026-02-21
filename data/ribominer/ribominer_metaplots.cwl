cwlVersion: v1.2
class: CommandLineTool
baseCommand: ribominer_metaplots
label: ribominer_metaplots
doc: "A tool from the RiboMiner suite for generating metaplots.\n\nTool homepage:
  https://github.com/xryanglab/RiboMiner"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ribominer:0.2.3.2--pyh5e36f6f_0
stdout: ribominer_metaplots.out
