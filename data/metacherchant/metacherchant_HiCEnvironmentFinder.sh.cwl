cwlVersion: v1.2
class: CommandLineTool
baseCommand: metacherchant_HiCEnvironmentFinder.sh
label: metacherchant_HiCEnvironmentFinder.sh
doc: "A script associated with the MetaMerchant tool suite, likely used for identifying
  Hi-C environments. Note: The provided text contains only system error logs and no
  usage information.\n\nTool homepage: https://github.com/ctlab/metacherchant"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metacherchant:0.1.0--1
stdout: metacherchant_HiCEnvironmentFinder.sh.out
