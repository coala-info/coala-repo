cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kmercamel
  - ms2mssep
label: kmercamel_ms2mssep
doc: "Converts MS/MS spectra to MS2 format.\n\nTool homepage: https://github.com/OndrejSladky/kmercamel/"
inputs:
  - id: ms_file
    type: File
    doc: Input MS/MS spectra file
    inputBinding:
      position: 1
  - id: output_mask_file_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `output_mask_file_path`
    inputBinding:
      position: 101
      prefix: --output-mask-file
  - id: output_superstring_file_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `output_superstring_file_path`
    inputBinding:
      position: 102
      prefix: --output-superstring-file
outputs:
  - id: output_mask_file
    type:
      - 'null'
      - File
    doc: Output file with mask
    outputBinding:
      glob: $(inputs.output_mask_file_path)
  - id: output_superstring_file
    type:
      - 'null'
      - File
    doc: Output file with superstring
    outputBinding:
      glob: $(inputs.output_superstring_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmercamel:2.2.0--ha119d93_0
