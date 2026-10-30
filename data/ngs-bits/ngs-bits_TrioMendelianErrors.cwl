cwlVersion: v1.2
class: CommandLineTool
baseCommand: TrioMendelianErrors
label: ngs-bits_TrioMendelianErrors
doc: "Determines mendelian error rate from a trio VCF.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: c
    type: string
    doc: "Sample name of child in VCF."
    inputBinding:
      position: 1
      prefix: -c
  - id: debug
    type:
      - 'null'
      - boolean
    doc: "Enable debug output"
    inputBinding:
      position: 2
      prefix: -debug
  - id: f
    type: string
    doc: "Sample name of father in VCF."
    inputBinding:
      position: 3
      prefix: -f
  - id: m
    type: string
    doc: "Sample name of mother in VCF."
    inputBinding:
      position: 4
      prefix: -m
  - id: min_dp
    type:
      - 'null'
      - int
    doc: "Minimum depth in each sample."
    inputBinding:
      position: 5
      prefix: -min_dp
  - id: min_qual
    type:
      - 'null'
      - float
    doc: "Minimum QUAL of variants."
    inputBinding:
      position: 6
      prefix: -min_qual
  - id: output_path
    type:
      - 'null'
      - string
    doc: "Output text file. If unset, writes to STDOUT."
    inputBinding:
      position: 7
      prefix: -out
  - id: settings_file
    type:
      - 'null'
      - File
    doc: "Settings override file (no other settings files are used)."
    inputBinding:
      position: 8
      prefix: --settings
  - id: vcf
    type: File
    doc: "Multi-sample VCF or VCF.GZ file."
    inputBinding:
      position: 9
      prefix: -vcf
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: "Output text file. If unset, writes to STDOUT."
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
