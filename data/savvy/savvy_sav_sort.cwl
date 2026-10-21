cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sav
  - sort
label: savvy_sav_sort
doc: "Sorts a SAV file.\n\nTool homepage: https://github.com/statgen/savvy"
inputs:
  - id: input_file
    type: File
    secondaryFiles:
      - pattern: .s1r
        required: false
    doc: Input SAV file
    inputBinding:
      position: 1
  - id: direction
    type:
      - 'null'
      - string
    doc: 'Specifies whether to sort in ascending or descending order (asc or desc; default: asc)'
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
  - id: output_path
    type: string
    doc: Path to output SAV file
    inputBinding:
      position: 103
      prefix: --output
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Path to output SAV file
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/savvy:2.1.0--h5b0a936_4
