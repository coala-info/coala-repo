cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sierrapy
  - recipe
label: sierrapy_recipe
doc: "Post process Sierra web service output.\n\nTool homepage: https://github.com/hivdb/sierra-client/tree/master/python"
inputs:
  - id: command
    type: string
    doc: Command to execute (alignment, mutationtsv, sequencetsv)
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the command
    inputBinding:
      position: 2
  - id: input_filename
    type:
      - 'null'
      - File
    doc: JSON result from Sierra web service.
    inputBinding:
      position: 103
      prefix: --input
  - id: output_filename_path
    type: string
    doc: Output or path parameter `output_filename_path`
    inputBinding:
      position: 104
      prefix: --output-filename
outputs:
  - id: output_filename
    type:
      - 'null'
      - File
    doc: File path to store the result.
    outputBinding:
      glob: $(inputs.output_filename_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sierrapy:0.4.3--pyh7cba7a3_0
