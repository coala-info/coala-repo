cwlVersion: v1.2
class: CommandLineTool
baseCommand: igda-script_add_gq_to_vcf
label: igda-script_add_gq_to_vcf
doc: "Add GQ (Genotype Quality) to a VCF file (Note: The provided text contains only
  system error messages and no help documentation; therefore, no arguments could be
  extracted).\n\nTool homepage: https://github.com/zhixingfeng/shell"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igda-script:1.0.1--hdfd78af_0
stdout: igda-script_add_gq_to_vcf.out
