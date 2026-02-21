cwlVersion: v1.2
class: CommandLineTool
baseCommand: count_constant_sites
label: count_constant_sites
doc: "Count constant sites in a FASTA file\n\nTool homepage: https://github.com/pvanheus/count_constant_sites"
inputs:
  - id: fasta_file
    type: File
    doc: Input FASTA file to process
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/count_constant_sites:0.1.1--0
stdout: count_constant_sites.out
