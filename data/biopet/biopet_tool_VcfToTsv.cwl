cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - biopet
  - tool
  - VcfToTsv
label: biopet_tool_VcfToTsv
doc: "Convert a VCF file to a tab-delimited table.\n\nTool homepage: https://github.com/biopet/biopet"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input_file
    type: File
    doc: Input vcf file
    inputBinding:
      position: 101
      prefix: --inputFile
  - id: output_file
    type:
      - 'null'
      - string
    doc: output file, default to stdout
    inputBinding:
      position: 101
      prefix: --outputFile
  - id: field
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --field
    doc: Genotype field to use
    inputBinding:
      position: 101
  - id: info_field
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --info_field
    doc: Info field to use
    inputBinding:
      position: 101
  - id: all_info
    type:
      - 'null'
      - boolean
    doc: Use all info fields in the vcf header
    inputBinding:
      position: 101
      prefix: --all_info
  - id: all_format
    type:
      - 'null'
      - boolean
    doc: Use all genotype fields in the vcf header
    inputBinding:
      position: 101
      prefix: --all_format
  - id: sample_field
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --sample_field
    doc: Genotype fields to use in the tsv file
    inputBinding:
      position: 101
  - id: disable_defaults
    type:
      - 'null'
      - boolean
    doc: Don't output the default columns from the vcf file
    inputBinding:
      position: 101
      prefix: --disable_defaults
  - id: separator
    type:
      - 'null'
      - string
    doc: Optional separator. Default is tab-delimited
    inputBinding:
      position: 101
      prefix: --separator
  - id: list_separator
    type:
      - 'null'
      - string
    doc: Optional list separator. By default, lists are separated by a comma
    inputBinding:
      position: 101
      prefix: --list_separator
  - id: max_decimals
    type:
      - 'null'
      - int
    doc: Number of decimal places for numbers. Default is 2
    inputBinding:
      position: 101
      prefix: --max_decimals
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Level of log information printed. Possible levels: ''debug'', ''info'', ''warn'',
      ''error'''
    inputBinding:
      position: 101
      prefix: --log_level
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: tsv
    type:
      - 'null'
      - File
    doc: Output TSV file
    outputBinding:
      glob: '$(inputs.output_file ? inputs.output_file : [])'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biopet:0.9.0--py36r3.3.2_0
stdout: biopet_tool_VcfToTsv.out
