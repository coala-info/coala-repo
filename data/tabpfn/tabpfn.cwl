cwlVersion: v1.2
class: CommandLineTool
baseCommand: tabpfn
label: tabpfn
doc: "The provided text does not contain help information or a description of the
  tool; it contains log messages regarding a failed container build/fetch process.\n
  \nTool homepage: https://github.com/PriorLabs/TabPFN"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tabpfn:2.0.3
stdout: tabpfn.out
