cwlVersion: v1.2
class: CommandLineTool
baseCommand: translate-gard
label: translate-gard
doc: "Translate GARD output to a different format.\n\nTool homepage: https://github.com/veg/translate-gard/"
arguments:
  - prefix: -j
    valueFrom: $(inputs.input_filename.path).json
inputs:
  - id: input_filename
    type: File
    secondaryFiles:
      - pattern: _finalout
        required: true
      - pattern: _ga_details
        required: true
      - pattern: _splits
        required: true
      - pattern: .json
        required: true
    doc: input filename (like CD2.nex.GARD.csv). The tool reads its JSON file only as INPUT.json (the -j option is set to this file), and also reads the GARD files INPUT_finalout, INPUT_ga_details, INPUT_splits and INPUT.json from the same folder.
    inputBinding:
      position: 101
      prefix: -i
  - id: output_filename_path
    type: string
    doc: output filename
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: output_filename
    type: File
    doc: output filename
    outputBinding:
      glob: $(inputs.output_filename_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/translate-gard:1.0.4--0
