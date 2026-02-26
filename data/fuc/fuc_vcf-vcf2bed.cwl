cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fuc
  - vcf-vcf2bed
label: fuc_vcf-vcf2bed
doc: "Convert a VCF file to a BED file.\n\nTool homepage: https://github.com/sbslee/fuc"
inputs:
  - id: vcf
    type: File
    doc: VCF file (compressed or uncompressed).
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
stdout: fuc_vcf-vcf2bed.out
