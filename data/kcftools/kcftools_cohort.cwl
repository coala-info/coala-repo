cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kcftools
  - cohort
label: kcftools_cohort
doc: "Create a cohort of samples kcf files\n\nTool homepage: https://github.com/sivasubramanics/kcftools"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: List of samples kcf files
    inputBinding:
      position: 101
      prefix: --input
      itemSeparator: ','
  - id: list_file
    type:
      - 'null'
      - File
    doc: File containing list of samples kcf files
    inputBinding:
      position: 101
      prefix: --list
  - id: output_file_path
    type: string
    doc: Output file name
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output_file
    type: File
    doc: Output file name
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kcftools:0.4.0--hdfd78af_0
