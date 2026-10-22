cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - svtools
  - bedpesort
label: svtools_bedpesort
doc: 'Sort a BEDPE file.


  Tool homepage: https://github.com/hall-lab/svtools'
inputs:
  - id: input_bedpe
    type: File
    doc: BEDPE file to sort
    inputBinding:
      position: 1
  - id: output_bedpe
    type: string
    doc: Output file to write to
    inputBinding:
      position: 2
outputs:
  - id: out_bedpe
    type: File
    doc: Sorted BEDPE
    outputBinding:
      glob: $(inputs.output_bedpe)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svtools:0.5.1--py_0
