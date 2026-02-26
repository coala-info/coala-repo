cwlVersion: v1.2
class: CommandLineTool
baseCommand: sylph-tax merge
label: sylph-tax_merge
doc: "Merge multiple sylph-tax taxonomy files into a single TSV table.\n\nTool homepage:
  https://github.com/bluenote-1577/sylph-tax"
inputs:
  - id: files
    type:
      type: array
      items: File
    doc: Paths to the *.sylphmpa files output by sylph-tax taxonomy
    inputBinding:
      position: 1
  - id: column
    type: string
    doc: The data type to output
    inputBinding:
      position: 102
      prefix: --column
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Name of the tsv table to output
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sylph-tax:1.8.0--pyhdfd78af_0
