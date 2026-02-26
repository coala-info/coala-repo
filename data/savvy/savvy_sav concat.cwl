cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sav
  - concat
label: savvy_sav concat
doc: "Concatenates SAV files.\n\nTool homepage: https://github.com/statgen/savvy"
inputs:
  - id: first_sav
    type: File
    doc: The first SAV file to concatenate.
    inputBinding:
      position: 1
  - id: second_sav
    type: File
    doc: The second SAV file to concatenate.
    inputBinding:
      position: 2
  - id: addl_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Additional SAV files to concatenate.
    inputBinding:
      position: 3
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/savvy:2.1.0--h5b0a936_4
