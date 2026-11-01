cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- BwaMemIndexImageCreator
label: gatk_BwaMemIndexImageCreator
doc: |-
  Create a BWA-MEM index image file for use with GATK BWA tools

  Tool homepage: https://gatk.broadinstitute.org/
inputs:
- id: input
  type: File
  doc: Input reference FASTA file location.
  inputBinding:
    position: 1
    prefix: --input
- id: output
  type:
  - 'null'
  - string
  default: reference.img
  doc: Output reference index image file (ending in ".img").
  inputBinding:
    position: 1
    prefix: --output
outputs:
- id: output_file
  type: File
  doc: Output reference index image file (ending in ".img").
  outputBinding:
    glob: $(inputs.output)
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:4.7.0.0
s:url: https://gatk.broadinstitute.org/
$namespaces:
  s: https://schema.org/
