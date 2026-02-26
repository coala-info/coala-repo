cwlVersion: v1.2
class: CommandLineTool
baseCommand: smof_cut
label: smof_cut
doc: "Cut fields from SMOF files.\n\nTool homepage: https://github.com/incertae-sedis/smof"
inputs:
  - id: input_file
    type: File
    doc: Input SMOF file
    inputBinding:
      position: 1
  - id: fields
    type: string
    doc: Comma-separated list of fields to cut
    inputBinding:
      position: 102
      prefix: --fields
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file to write results to
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smof:2.22.4--pyhdfd78af_0
