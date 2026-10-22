cwlVersion: v1.2
class: CommandLineTool
baseCommand: create_coordinates
label: svtools_create_coordinates
doc: 'Generate the BED coordinate file required by the svtools copynumber annotation
  program.


  Tool homepage: https://github.com/hall-lab/svtools'
inputs:
  - id: input_vcf
    type: File
    doc: VCF input
    inputBinding:
      position: 101
      prefix: --input_vcf
  - id: output
    type: string
    doc: 'Output coordinates to write (default: stdout)'
    inputBinding:
      position: 101
      prefix: --output
outputs:
  - id: out_coordinates
    type: File
    doc: Coordinates file
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svtools:0.5.1--py_0
