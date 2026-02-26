cwlVersion: v1.2
class: CommandLineTool
baseCommand: ropebwt3_plain2fmd
label: ropebwt3_plain2fmd
doc: "Convert plain text to FM-index\n\nTool homepage: https://github.com/lh3/ropebwt3"
inputs:
  - id: input_file
    type: File
    doc: Input plain text file
    inputBinding:
      position: 1
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output FM-index file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ropebwt3:3.10--h577a1d6_0
