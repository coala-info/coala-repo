cwlVersion: v1.2
class: CommandLineTool
baseCommand: dmtools chrmeth
label: dmtools_chrmeth
doc: "Calculates chromosome methylation statistics from a DM file.\n\nTool homepage:
  https://github.com/ZhouQiangwei/dmtools"
inputs:
  - id: chromosome
    type:
      - 'null'
      - string
    doc: chromosome for cal.
    inputBinding:
      position: 101
      prefix: --chr
  - id: input_dm_file
    type: File
    doc: input DM file
    inputBinding:
      position: 101
      prefix: -i
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dmtools:0.2.6--hda3def1_0
