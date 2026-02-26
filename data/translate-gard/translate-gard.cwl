cwlVersion: v1.2
class: CommandLineTool
baseCommand: translate-gard
label: translate-gard
doc: "Translate GARD output to a different format.\n\nTool homepage: https://github.com/veg/translate-gard/"
inputs:
  - id: input_filename
    type: File
    doc: input filename (like CD2.nex.GARD.csv)
    inputBinding:
      position: 101
      prefix: -i
  - id: json_filename
    type: File
    doc: json filename (like CD2.nex.out.json
    inputBinding:
      position: 101
      prefix: -j
outputs:
  - id: output_filename
    type: File
    doc: output filename
    outputBinding:
      glob: $(inputs.output_filename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/translate-gard:1.0.4--0
