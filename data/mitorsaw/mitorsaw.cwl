cwlVersion: v1.2
class: CommandLineTool
baseCommand: mitorsaw
label: mitorsaw
doc: "a tool for haplotyping mitochondria from HiFi data. Select a subcommand to see
  more usage information:\n\nTool homepage: https://github.com/PacificBiosciences/mitorsaw"
inputs:
  - id: command
    type: string
    doc: The subcommand to run (build, haplotype, help)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mitorsaw:0.2.7--h9ee0642_0
stdout: mitorsaw.out
