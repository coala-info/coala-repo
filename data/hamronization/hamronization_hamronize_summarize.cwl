cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hamronize
  - summarize
label: hamronization_hamronize_summarize
doc: "Concatenate and summarize AMR detection reports\n\nTool homepage: https://github.com/pha4ge/hAMRonization"
inputs:
  - id: hamronized_reports
    type:
      type: array
      items: File
    doc: list of hAMRonized reports
    inputBinding:
      position: 1
  - id: summary_type
    type:
      - 'null'
      - string
    doc: Which summary report format to generate
    inputBinding:
      position: 102
      prefix: --summary_type
  - id: output_path
    type: string
    doc: Output file path for summary
    inputBinding:
      position: 103
      prefix: --output
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file path for summary
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hamronization:1.1.9--pyhdfd78af_1
