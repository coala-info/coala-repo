cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sav
  - rehead
label: savvy_sav_rehead
doc: "Replace headers in a SAV file.\n\nTool homepage: https://github.com/statgen/savvy"
inputs:
  - id: headers_file
    type:
      - 'null'
      - File
    doc: File containing new headers
    inputBinding:
      position: 1
  - id: input_sav
    type: File
    doc: Input SAV file
    inputBinding:
      position: 2
  - id: out_sav
    type: string
    doc: Output SAV file
    inputBinding:
      position: 3
  - id: sample_ids_file
    type:
      - 'null'
      - File
    doc: Path to file containing list of sample IDs that will replace existing 
      IDs.
    inputBinding:
      position: 103
      prefix: -I
outputs:
  - id: output_sav
    type: File
    doc: Output SAV file
    outputBinding:
      glob: '$(inputs.out_sav)'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/savvy:2.1.0--h5b0a936_4
