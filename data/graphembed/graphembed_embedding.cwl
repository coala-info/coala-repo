cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - graphembed
  - embedding
label: graphembed_embedding
doc: "Graph/Network Embedding\n\nTool homepage: https://github.com/jean-pierreBoth/graphembed"
inputs:
  - id: command
    type: string
    doc: Command to execute (hope, sketching, help)
    inputBinding:
      position: 1
  - id: csvfile
    type: File
    doc: Input CSV file
    inputBinding:
      position: 102
      prefix: --csv
  - id: symetry
    type: string
    doc: Symmetry type
    inputBinding:
      position: 102
      prefix: --symetric
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file name for dump in .bson format
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/graphembed:0.1.8--h2e3eeea_0
