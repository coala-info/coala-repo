cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - svtools
  - vcftobedpe
label: svtools_svtools vcftobedpe
doc: "Convert a VCF file to a BEDPE file\n\nTool homepage: https://github.com/hall-lab/svtools"
inputs:
  - id: input_vcf
    type:
      - 'null'
      - File
    doc: 'VCF input (default: stdin)'
    inputBinding:
      position: 101
      prefix: --input
outputs:
  - id: output_bedpe
    type:
      - 'null'
      - File
    doc: 'BEDPE output (default: stdout)'
    outputBinding:
      glob: $(inputs.output_bedpe)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svtools:0.5.1--py_0
