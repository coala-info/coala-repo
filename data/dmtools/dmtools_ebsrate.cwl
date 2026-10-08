cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dmtools
  - ebsrate
label: dmtools_ebsrate
doc: "Calculate bisulfite conversion rate from DM file.\n\nTool homepage: https://github.com/ZhouQiangwei/dmtools"
inputs:
  - id: bsmode
    type:
      - 'null'
      - string
    doc: chg, chh or chr mode, suggest chg/chh for human, mouse etc.
    inputBinding:
      position: 101
      prefix: --bsmode
  - id: chr
    type:
      - 'null'
      - string
    doc: chromosome level used for calculate bisulfite convertion rate, default,
      chrM and chrC
    inputBinding:
      position: 101
      prefix: --chr
  - id: input_dm_file
    type: File
    doc: input DM file
    inputBinding:
      position: 101
      prefix: -i
  - id: output_file_path
    type: string
    doc: output file
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dmtools:0.2.6--hda3def1_0
