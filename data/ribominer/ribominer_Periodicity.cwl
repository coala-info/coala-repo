cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ribominer
  - Periodicity
label: ribominer_Periodicity
doc: "A tool for periodicity analysis as part of the RiboMiner suite. Note: The provided
  help text contained only system error logs and did not list specific arguments.\n
  \nTool homepage: https://github.com/xryanglab/RiboMiner"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ribominer:0.2.3.2--pyh5e36f6f_0
stdout: ribominer_Periodicity.out
