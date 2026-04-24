cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sierrapy
  - mutations
label: sierrapy_mutations
doc: "Run drug resistance and other analysis for PR, RT and/or IN mutations.\n\nTool
  homepage: https://github.com/hivdb/sierra-client/tree/master/python"
inputs:
  - id: mutations
    type:
      type: array
      items: string
    doc: PR, RT and/or IN mutations
    inputBinding:
      position: 1
  - id: query_file
    type:
      - 'null'
      - File
    doc: A file contains GraphQL fragment definition on `MutationsAnalysis`.
    inputBinding:
      position: 102
      prefix: --query
  - id: ugly
    type:
      - 'null'
      - boolean
    doc: Output compressed JSON result.
    inputBinding:
      position: 102
      prefix: --ugly
  - id: url
    type:
      - 'null'
      - string
    doc: URL of Sierra GraphQL Web Service.
    inputBinding:
      position: 102
      prefix: --url
  - id: virus
    type:
      - 'null'
      - string
    doc: Specify virus to be analyzed.
    inputBinding:
      position: 102
      prefix: --virus
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: File path to store the JSON result.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sierrapy:0.4.3--pyh7cba7a3_0
