cwlVersion: v1.2
class: CommandLineTool
baseCommand: VcfToTsv
label: ngs-bits_VcfToTsv
doc: "Converts a VCF file to a tab-separated text file. Multi-allelic variants are supported. All alternative sequences are stored as a comma-seperated list. Multi-sample VCFs are supported. For every combination of FORMAT and SAMPLE a seperate column is generated and named in the following way: <SAMPLEID>_<FORMATID>_<format>.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: "Input variant list in VCF or VCF.GZ format. If unset, reads from STDIN."
    inputBinding:
      position: 1
      prefix: -in
  - id: output_path
    type:
      - 'null'
      - string
    doc: "Output variant list in TSV format. If unset, writes to STDOUT."
    inputBinding:
      position: 2
      prefix: -out
  - id: settings_file
    type:
      - 'null'
      - File
    doc: "Settings override file (no other settings files are used)."
    inputBinding:
      position: 3
      prefix: --settings
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: "Output variant list in TSV format. If unset, writes to STDOUT."
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
