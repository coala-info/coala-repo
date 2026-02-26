cwlVersion: v1.2
class: CommandLineTool
baseCommand: vargeno
label: vargeno_geno
doc: "vargeno <option> [option parameters ...]\n\nTool homepage: https://github.com/medvedevgroup/vargeno"
inputs:
  - id: option
    type: string
    doc: The subcommand to run (index or geno)
    inputBinding:
      position: 1
  - id: input_fasta
    type: File
    doc: Input FASTA file for index subcommand
    inputBinding:
      position: 2
  - id: input_fastq
    type: File
    doc: Input FASTQ file for geno subcommand
    inputBinding:
      position: 3
  - id: input_snps_vcf_index
    type: File
    doc: Input SNPs in VCF file for index subcommand
    inputBinding:
      position: 4
  - id: index_prefix
    type: string
    doc: Prefix for the index file for index subcommand
    inputBinding:
      position: 5
outputs:
  - id: output_file
    type: File
    doc: Output file in VCF format for geno subcommand
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vargeno:1.0.3--h9948957_6
