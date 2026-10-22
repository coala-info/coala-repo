cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sierrapy
  - recipe
label: sierrapy_recipe_mutationtsv
doc: "Export mutation set of each sequences from Sierra result.\n\nTool homepage: https://github.com/hivdb/sierra-client/tree/master/python"
inputs:
  - id: input_filename
    type: File
    doc: JSON result from Sierra web service.
    inputBinding:
      position: 1
      prefix: --input
  - id: output_filename
    type: string
    doc: File path to store the result.
    inputBinding:
      position: 2
      prefix: --output
arguments:
  - position: 3
    valueFrom: mutationtsv
outputs:
  - id: result
    type: File
    doc: File path to store the result.
    outputBinding:
      glob: $(inputs.output_filename)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sierrapy:0.4.3--pyh7cba7a3_0
