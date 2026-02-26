cwlVersion: v1.2
class: CommandLineTool
baseCommand: lorikeet
label: lorikeet-genome_lorikeet
doc: "Variant calling and strain genotyping analysis for metagenomics\n\nTool homepage:
  https://github.com/rhysnewell/Lorikeet"
inputs:
  - id: subcommand
    type: string
    doc: 'The subcommand to run. Available subcommands: call, consensus, summarise,
      shell-completion, genotype'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lorikeet-genome:0.8.2--h8e1a5b0_0
stdout: lorikeet-genome_lorikeet.out
