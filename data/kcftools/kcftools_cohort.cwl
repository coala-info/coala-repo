cwlVersion: v1.2
class: CommandLineTool
baseCommand: kcftools_cohort
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
  - id: list_file
    type:
      - 'null'
      - File
    doc: File containing list of samples kcf files
    inputBinding:
      position: 101
      prefix: --list
outputs:
  - id: output_file
    type: File
    doc: Output file name
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kcftools:0.4.0--hdfd78af_0
