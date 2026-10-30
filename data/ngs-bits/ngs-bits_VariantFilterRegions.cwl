cwlVersion: v1.2
class: CommandLineTool
baseCommand: VariantFilterRegions
label: ngs-bits_VariantFilterRegions
doc: "Filter a variant list based on a target region.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: compression_level
    type:
      - 'null'
      - int
    doc: "Output VCF compression level from 1 (fastest) to 9 (best compression). If unset, an unzipped VCF is written."
    inputBinding:
      position: 1
      prefix: -compression_level
  - id: input_file
    type: File
    doc: "Input variant list. In VCF (default) or GSvar format."
    inputBinding:
      position: 2
      prefix: -in
  - id: inv
    type:
      - 'null'
      - boolean
    doc: "Inverts the filter, i.e. variants inside the region are removed/marked."
    inputBinding:
      position: 3
      prefix: -inv
  - id: mark
    type:
      - 'null'
      - string
    doc: "If set, instead of removing variants, they are marked with the given flag in the 'filter' column."
    inputBinding:
      position: 4
      prefix: -mark
  - id: mode
    type:
      - 'null'
      - string
    doc: "Mode (input format). Valid: 'vcf,gsvar'"
    inputBinding:
      position: 5
      prefix: -mode
  - id: output_path
    type:
      - 'null'
      - string
    doc: "Output variant list (same format as 'in'). If unset, writes to STDOUT."
    inputBinding:
      position: 6
      prefix: -out
  - id: r
    type:
      - 'null'
      - string
    doc: "Single target region in the format chr17:41194312-41279500."
    inputBinding:
      position: 7
      prefix: -r
  - id: reg
    type:
      - 'null'
      - File
    doc: "Input target region in BED format."
    inputBinding:
      position: 8
      prefix: -reg
  - id: settings_file
    type:
      - 'null'
      - File
    doc: "Settings override file (no other settings files are used)."
    inputBinding:
      position: 9
      prefix: --settings
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: "Output variant list (same format as 'in'). If unset, writes to STDOUT."
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
