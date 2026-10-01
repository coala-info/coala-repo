cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - genometreetk
  - fill_ranks
label: genometreetk_fill_ranks
doc: "Ensure taxonomy strings contain all 7 canonical ranks.\n\nTool homepage: http://pypi.python.org/pypi/genometreetk/"
inputs:
  - id: input_taxonomy
    type: File
    doc: input taxonomy file
    inputBinding:
      position: 1
  - id: output_taxonomy
    type: string
    doc: output taxonomy file
    inputBinding:
      position: 2
  - id: silent
    type:
      - 'null'
      - boolean
    doc: suppress output
    inputBinding:
      position: 103
      prefix: --silent
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_taxonomy_out
    type:
      - 'null'
      - File
    doc: output taxonomy file
    outputBinding:
      glob: $(inputs.output_taxonomy)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genometreetk:0.1.6--py_2
stdout: genometreetk_fill_ranks.out
