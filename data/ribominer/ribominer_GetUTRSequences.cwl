cwlVersion: v1.2
class: CommandLineTool
baseCommand: ribominer_GetUTRSequences
label: ribominer_GetUTRSequences
doc: "The provided text does not contain help information for the tool; it is a container
  runtime error log. No arguments could be extracted.\n\nTool homepage: https://github.com/xryanglab/RiboMiner"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ribominer:0.2.3.2--pyh5e36f6f_0
stdout: ribominer_GetUTRSequences.out
