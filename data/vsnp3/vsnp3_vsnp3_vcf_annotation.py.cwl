cwlVersion: v1.2
class: CommandLineTool
baseCommand: vsnp3_vcf_annotation.py
label: vsnp3_vsnp3_vcf_annotation.py
doc: "Annotate a VCF file with GenBank gene information. The annotated VCF is written beside\
  \ the input VCF.\n\nTool homepage: https://github.com/USDA-VS/vsnp3"
inputs:
  - id: gbk_list
    type:
      - 'null'
      - type: array
        items: File
    doc: 'Optional: gbk to annotate VCF file. Multiple can be specified with wildcard'
    inputBinding:
      position: 101
      prefix: -b
  - id: vcf
    type: File
    doc: Provide VCF file, Return VCF annotated
    inputBinding:
      position: 101
      prefix: -c
      valueFrom: $(self.basename)
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: annotated_vcf
    type: File
    doc: Annotated VCF file
    outputBinding:
      glob: '*_annotated.vcf'
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.vcf)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vsnp3:3.33--hdfd78af_0
stdout: vsnp3_vsnp3_vcf_annotation.py.stdout.txt
