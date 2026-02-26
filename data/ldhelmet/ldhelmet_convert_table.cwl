cwlVersion: v1.2
class: CommandLineTool
baseCommand: ldhelmet_convert_table
label: ldhelmet_convert_table
doc: "Converts LDhat style tables to a format suitable for LDhelmet.\n\nTool homepage:
  http://sourceforge.net/projects/ldhelmet/"
inputs:
  - id: config_file
    type:
      - 'null'
      - File
    doc: (Optional) File with configs. This is only necessary if you have 
      missing data.
    inputBinding:
      position: 101
      prefix: --config_file
  - id: input_table
    type: File
    doc: LDhat style table to be converted.
    inputBinding:
      position: 101
      prefix: --input_table
outputs:
  - id: output_table
    type: File
    doc: Name for output file.
    outputBinding:
      glob: $(inputs.output_table)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ldhelmet:1.10--h0704011_8
