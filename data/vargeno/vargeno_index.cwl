cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vargeno
  - index
label: vargeno_index
doc: "Generate the VarGeno index of a reference FASTA and a SNP list in VCF format.\n\
  \nTool homepage: https://github.com/medvedevgroup/vargeno"
inputs:
  - id: input_fasta
    type: File
    doc: Input reference FASTA
    inputBinding:
      position: 1
  - id: input_snps_vcf
    type: File
    doc: Input SNPs in VCF format
    inputBinding:
      position: 2
  - id: index_prefix
    type: string
    doc: Prefix of the index files to write
    inputBinding:
      position: 3
outputs:
  - id: index_files
    type:
      type: array
      items: File
    doc: Index files written with the given prefix
    outputBinding:
      glob: $(inputs.index_prefix)*
requirements:
  - class: ResourceRequirement
    ramMin: 8000
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vargeno:1.0.3--h9948957_6
