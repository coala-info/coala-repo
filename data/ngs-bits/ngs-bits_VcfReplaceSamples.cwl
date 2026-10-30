cwlVersion: v1.2
class: CommandLineTool
baseCommand: VcfReplaceSamples
label: ngs-bits_VcfReplaceSamples
doc: "Replaces sample identifiers in the VCF header. Note: the sample ID matching is performed case-sensitive.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: compression_level
    type:
      - 'null'
      - int
    doc: "Output VCF compression level from 1 (fastest) to 9 (best compression). If unset, an unzipped VCF is written."
    inputBinding:
      position: 1
      prefix: -compression_level
  - id: ids
    type: string
    doc: "Comma-separated list of sample ID pairs in the format 'old1=new1,old2=new2,...'."
    inputBinding:
      position: 2
      prefix: -ids
  - id: input_file
    type:
      - 'null'
      - File
    doc: "Input variant list in VCF or VCF.GZ format. If unset, reads from STDIN."
    inputBinding:
      position: 3
      prefix: -in
  - id: output_path
    type:
      - 'null'
      - string
    doc: "Output variant list in VCF format. If unset, writes to STDOUT."
    inputBinding:
      position: 4
      prefix: -out
  - id: settings_file
    type:
      - 'null'
      - File
    doc: "Settings override file (no other settings files are used)."
    inputBinding:
      position: 5
      prefix: --settings
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: "Output variant list in VCF format. If unset, writes to STDOUT."
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
