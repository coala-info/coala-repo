cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seshat
  - merge
label: seshat_merge
doc: 'Merge Seshat annotations with a VCF file.


  Tool homepage: https://github.com/clintval/tp53'
inputs:
  - id: input_vcf
    type: File
    doc: The path to the input VCF file.
    inputBinding:
      position: 1
      prefix: --input
  - id: annotations
    type: File
    doc: The annotation text file output from Seshat.
    inputBinding:
      position: 2
      prefix: --annotations
  - id: output_vcf_path
    type: string
    doc: The path to the output VCF file.
    inputBinding:
      position: 3
      prefix: --output
outputs:
  - id: output_vcf
    type: File
    doc: The annotated VCF file.
    outputBinding:
      glob: $(inputs.output_vcf_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seshat:0.10.0--py313hdfd78af_0
