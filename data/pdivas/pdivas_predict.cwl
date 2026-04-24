cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pdivas
  - predict
label: pdivas_predict
doc: "Add PDIVAS annotation to a VCF file and predict deep-intronic variants.\n\n
  Tool homepage: https://github.com/shiro-kur/PDIVAS"
inputs:
  - id: filtering
    type:
      - 'null'
      - string
    doc: Output all variants (-F off; default) or only deep-intronic variants with
      PDIVAS scores (-F on)
    inputBinding:
      position: 101
      prefix: -F
  - id: input_vcf
    type: File
    doc: The path to the vcf(.gz) file to add PDIVAS annotation
    inputBinding:
      position: 101
      prefix: -I
outputs:
  - id: output_vcf
    type: File
    doc: The path to output vcf(.gz) file name and pass
    outputBinding:
      glob: $(inputs.output_vcf)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pdivas:1.2.0--pyh7e72e81_0
