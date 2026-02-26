cwlVersion: v1.2
class: CommandLineTool
baseCommand: add_gq_to_vcf
label: igda-script_add_gq_to_vcf
doc: "Add GQ (Genotype Quality) to VCF file\n\nTool homepage: https://github.com/zhixingfeng/shell"
inputs:
  - id: in_vcf_file
    type: File
    doc: Input VCF file
    inputBinding:
      position: 1
outputs:
  - id: out_vcf_file
    type: File
    doc: Output VCF file with added GQ
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igda-script:1.0.1--hdfd78af_0
