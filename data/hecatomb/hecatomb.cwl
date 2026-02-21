cwlVersion: v1.2
class: CommandLineTool
baseCommand: hecatomb
label: hecatomb
doc: "A pipeline for viral metagenomics. (Note: The provided text is a system error
  log and does not contain command-line help information or argument definitions.)\n
  \nTool homepage: https://github.com/shandley/hecatomb"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hecatomb:1.3.4--pyh7e72e81_0
stdout: hecatomb.out
