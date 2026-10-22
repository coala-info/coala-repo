cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - svtools
  - vcfsort
label: svtools_vcfsort
doc: 'Sort a VCF file.


  Tool homepage: https://github.com/hall-lab/svtools'
inputs:
  - id: input_vcf
    type: File
    doc: 'VCF file to sort (default: stdin)'
    inputBinding:
      position: 1
  - id: output_vcf
    type: string
    doc: 'Output file to write to (default: stdout)'
    inputBinding:
      position: 2
outputs:
  - id: out_vcf
    type: File
    doc: Sorted VCF
    outputBinding:
      glob: $(inputs.output_vcf)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svtools:0.5.1--py_0
