cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sav
  - rehead
label: savvy_sav rehead
doc: "Replace headers in a SAV file.\n\nTool homepage: https://github.com/statgen/savvy"
inputs:
  - id: headers_file
    type: File
    doc: File containing new headers
    inputBinding:
      position: 1
  - id: input_sav
    type: File
    doc: Input SAV file
    inputBinding:
      position: 2
  - id: sample_ids_file
    type: File
    doc: Path to file containing list of sample IDs that will replace existing 
      IDs.
    inputBinding:
      position: 103
      prefix: --sample-ids
outputs:
  - id: output_sav
    type: File
    doc: Output SAV file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/savvy:2.1.0--h5b0a936_4
