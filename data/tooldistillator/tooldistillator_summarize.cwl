cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tooldistillator
  - summarize
label: tooldistillator_summarize
doc: "Aggregate several reports\n\nTool homepage: https://gitlab.com/ifb-elixirfr/abromics"
inputs:
  - id: tooldistillator_reports
    type:
      type: array
      items: File
    doc: list of tooldistillator reports
    inputBinding:
      position: 1
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite to the output file mandatory
    inputBinding:
      position: 102
      prefix: --force
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file path for summary
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tooldistillator:1.0.5--pyh7e72e81_0
