cwlVersion: v1.2
class: CommandLineTool
baseCommand: vargeno
label: vargeno_index
doc: "vargeno\n\nTool homepage: https://github.com/medvedevgroup/vargeno"
inputs:
  - id: geno_index_prefix
    type: string
    doc: index_prefix
    inputBinding:
      position: 1
  - id: index_input_fasta
    type: File
    doc: input FASTA
    inputBinding:
      position: 2
  - id: geno_input_fastq
    type: File
    doc: input FASTQ
    inputBinding:
      position: 3
  - id: index_input_snps_vcf
    type: File
    doc: input SNPs in VCF
    inputBinding:
      position: 4
  - id: geno_input_snps_vcf
    type: File
    doc: input SNPs in VCF
    inputBinding:
      position: 5
  - id: index_prefix
    type: string
    doc: index_prefix
    inputBinding:
      position: 6
  - id: option
    type: string
    doc: Option to choose between index and geno
    inputBinding:
      position: 107
outputs:
  - id: geno_output_file
    type: File
    doc: output file in VCF
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vargeno:1.0.3--h9948957_6
