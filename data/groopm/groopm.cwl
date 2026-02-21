cwlVersion: v1.2
class: CommandLineTool
baseCommand: groopm
label: groopm
doc: "GroopM is a tool for automated binning of metagenomic contigs.\n\nTool homepage:
  https://ecogenomics.github.io/GroopM/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/groopm:0.3.4--pyhdfd78af_2
stdout: groopm.out
