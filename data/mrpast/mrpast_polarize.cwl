cwlVersion: v1.2
class: CommandLineTool
baseCommand: mrpast_polarize
label: mrpast_polarize
doc: "Polarize VCF file based on ancestral FASTA file.\n\nTool homepage: https://aprilweilab.github.io/"
inputs:
  - id: vcf_file
    type: File
    doc: The input VCF file.
    inputBinding:
      position: 1
  - id: ancestral
    type: File
    doc: The ancestral FASTA file (input). Assumes the positions start counting 
      at 1.
    inputBinding:
      position: 2
  - id: out_prefix
    type: string
    doc: The output prefix for the haps/sample results.
    inputBinding:
      position: 3
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrpast:0.2--py312h8f4af18_0
stdout: mrpast_polarize.out
