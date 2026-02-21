cwlVersion: v1.2
class: CommandLineTool
baseCommand: ribominer_GetProteinCodingSequence
label: ribominer_GetProteinCodingSequence
doc: "The provided text does not contain help information for the tool, but appears
  to be a container engine error log. No arguments could be parsed.\n\nTool homepage:
  https://github.com/xryanglab/RiboMiner"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ribominer:0.2.3.2--pyh5e36f6f_0
stdout: ribominer_GetProteinCodingSequence.out
