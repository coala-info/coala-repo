cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - add_gq_to_vcf
label: igda-script_add_gq_to_vcf
doc: "Add a GQ (genotype quality = 100) FORMAT field and a SAMPLE column to every record of a VCF file.\nUsage: add_gq_to_vcf in_vcf_file out_vcf_file\n\nTool homepage: https://github.com/zhixingfeng/shell"
inputs:
  - id: in_vcf_file
    type: File
    doc: "input VCF file"
    inputBinding:
      position: 1
  - id: out_vcf_file
    type: string
    doc: "output VCF file name"
    inputBinding:
      position: 2
outputs:
  - id: out_vcf
    type: File
    doc: "VCF file with GQ added"
    outputBinding:
      glob: $(inputs.out_vcf_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igda-script:1.0.1--hdfd78af_0
