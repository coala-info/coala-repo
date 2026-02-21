cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pdivas
  - vcf2tsv
label: pdivas_vcf2tsv
doc: "Convert PDIVAS annotated VCF files to TSV format\n\nTool homepage: https://github.com/shiro-kur/PDIVAS"
inputs:
  - id: input_vcf
    type: File
    doc: The path to the vcf(.gz) file with PDIVAS annotation
    inputBinding:
      position: 101
      prefix: -I
outputs:
  - id: output_tsv
    type: File
    doc: The path to output tsv file name and pass
    outputBinding:
      glob: $(inputs.output_tsv)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pdivas:1.2.0--pyh7e72e81_0
