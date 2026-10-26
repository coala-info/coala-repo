cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vargeno
  - geno
label: vargeno_geno
doc: "Perform SNP genotyping from FASTQ reads with a VarGeno index.\n\nTool homepage:\
  \ https://github.com/medvedevgroup/vargeno"
inputs:
  - id: index_prefix
    type: string
    doc: Prefix of the index files made by vargeno index
    inputBinding:
      position: 1
  - id: index_files
    type:
      type: array
      items: File
    doc: Index files written by vargeno index (staged so that the prefix resolves)
  - id: input_fastq
    type: File
    doc: Input reads in FASTQ format
    inputBinding:
      position: 2
  - id: input_snps_vcf
    type: File
    doc: Input SNPs in VCF format
    inputBinding:
      position: 3
  - id: output_vcf_path
    type: string
    doc: Output file in VCF format
    inputBinding:
      position: 4
outputs:
  - id: output_vcf
    type: File
    doc: Genotyped VCF file
    outputBinding:
      glob: $(inputs.output_vcf_path)
requirements:
  - class: InitialWorkDirRequirement
    listing: $(inputs.index_files)
  - class: ResourceRequirement
    ramMin: 8000
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vargeno:1.0.3--h9948957_6
