cwlVersion: v1.2
class: CommandLineTool
baseCommand: taxmapper_count
label: taxmapper_count
doc: "Count taxa based on a filtered taxonomy mapping file.\n\nTool homepage: https://bitbucket.org/dbeisser/taxmapper"
inputs:
  - id: taxa_file
    type: File
    doc: Filtered taxonomy mapping file.
    inputBinding:
      position: 101
      prefix: --tax
outputs:
  - id: output1
    type:
      - 'null'
      - File
    doc: Output file 1, counted taxa for first taxonomic hierarchy
    outputBinding:
      glob: $(inputs.output1)
  - id: output2
    type:
      - 'null'
      - File
    doc: Output file 2, counted taxa for second taxonomic hierarchy
    outputBinding:
      glob: $(inputs.output2)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxmapper:1.0.2--py36_0
