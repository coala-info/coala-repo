cwlVersion: v1.2
class: CommandLineTool
baseCommand: smoove
label: smoove_duphold
doc: "Call germline structural variants from sequencing data.\n\nTool homepage: https://github.com/brentp/smoove"
inputs:
  - id: bams
    type:
      type: array
      items: File
    doc: paths to sample BAM/CRAMs
    inputBinding:
      position: 1
  - id: fasta
    type: File
    doc: fasta file.
    inputBinding:
      position: 102
      prefix: --fasta
  - id: processes
    type:
      - 'null'
      - int
    doc: number of threads ot use.
    inputBinding:
      position: 102
      prefix: --processes
  - id: snps
    type:
      - 'null'
      - File
    doc: optional path to SNP/Indel VCF containing these samples for annotation 
      with allele balance.
    inputBinding:
      position: 102
      prefix: --snps
  - id: vcf
    type: File
    doc: path to input SV VCF
    inputBinding:
      position: 102
      prefix: --vcf
  - id: outvcf_path
    type: string
    doc: Output or path parameter `outvcf_path`
    inputBinding:
      position: 103
      prefix: --outvcf
outputs:
  - id: outvcf
    type: File
    doc: path to output SV VCF
    outputBinding:
      glob: $(inputs.outvcf_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smoove:0.2.8--h9ee0642_1
