cwlVersion: v1.2
class: CommandLineTool
baseCommand: VcfToBedpe
label: ngs-bits_VcfToBedpe
doc: "Converts a VCF file containing structural variants to BEDPE format. Input can be MANTA oder DELLY VCF files.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: input_file
    type: File
    doc: "Input structural variant list in VCF or VCF.GZ format."
    inputBinding:
      position: 1
      prefix: -in
  - id: no_sort
    type:
      - 'null'
      - boolean
    doc: "Do not sort results"
    inputBinding:
      position: 2
      prefix: -no_sort
  - id: output_path
    type: string
    doc: "Output structural variant list in BEDPE format."
    inputBinding:
      position: 3
      prefix: -out
  - id: settings_file
    type:
      - 'null'
      - File
    doc: "Settings override file (no other settings files are used)."
    inputBinding:
      position: 4
      prefix: --settings
outputs:
  - id: output_file
    type: File
    doc: "Output structural variant list in BEDPE format."
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
