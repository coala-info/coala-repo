cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - panaln
  - combine
label: panaln_combine
doc: "Generate Pangenome by combining FASTA and VCF files\n\nTool homepage: https://github.com/Lilu-guo/Panaln"
inputs:
  - id: basename
    type: string
    doc: Basename for the output files
    inputBinding:
      position: 101
      prefix: -b
  - id: input_fasta
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 101
      prefix: -s
  - id: input_vcf
    type: File
    doc: Input VCF file
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/panaln:2.09--h5ca1c30_0
stdout: panaln_combine.out
