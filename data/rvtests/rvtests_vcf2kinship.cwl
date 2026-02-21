cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcf2kinship
label: rvtests_vcf2kinship
doc: "The provided text does not contain help information for the tool; it is a log
  of a failed container build process. However, based on the tool name hint 'rvtests_vcf2kinship',
  this tool is used to calculate kinship matrices from VCF files.\n\nTool homepage:
  https://github.com/zhanxw/rvtests"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rvtests:2.0.7--h3d151dd_2
stdout: rvtests_vcf2kinship.out
