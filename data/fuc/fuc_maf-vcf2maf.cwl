cwlVersion: v1.2
class: CommandLineTool
baseCommand: fuc maf-vcf2maf
label: fuc_maf-vcf2maf
doc: "Convert a VCF file to a MAF file.\n\nTool homepage: https://github.com/sbslee/fuc"
inputs:
  - id: vcf
    type: File
    doc: Annotated VCF file.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
stdout: fuc_maf-vcf2maf.out
