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
outputs:
  - id: output_mask_file
    type:
      - 'null'
      - File
    doc: Output file with mask
    outputBinding:
      glob: $(inputs.output_mask_file)
  - id: output_superstring_file
    type:
      - 'null'
      - File
    doc: Output file with superstring
    outputBinding:
      glob: $(inputs.output_superstring_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmercamel:2.2.0--ha119d93_0
