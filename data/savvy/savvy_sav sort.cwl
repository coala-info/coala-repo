cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - savvy
  - sav
  - sort
label: savvy_sav sort
doc: "Sorts a SAV file.\n\nTool homepage: https://github.com/statgen/savvy"
inputs:
  - id: input_file
    type: File
    doc: Input SAV file
    inputBinding:
      position: 1
  - id: direction
    type:
      - 'null'
      - string
    doc: 'Specifies whether to sort in ascending or descending order (asc or desc;
    inputBinding:
      position: 102
      prefix: --direction
  - id: point
    type:
      - 'null'
      - string
    doc: 'Specifies which allele position to sort by (beg, mid or end; default: beg)'
    inputBinding:
      position: 102
      prefix: --point
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Path to output SAV file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/savvy:2.1.0--h5b0a936_4
