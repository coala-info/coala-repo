cwlVersion: v1.2
class: CommandLineTool
baseCommand: rename_gtf.py
label: tsebra_rename_gtf
doc: "Renames the transcripts and genes of a GTF file.\n\nTool homepage: https://github.com/Gaius-Augustus/TSEBRA"
inputs:
  - id: gtf
    type: File
    doc: "Path to a gene prediction file in GTF format, for example the output of TSEBRA"
    inputBinding:
      position: 101
      prefix: --gtf
  - id: prefix
    type:
      - 'null'
      - string
    doc: "The string is added as a prefix to all transcript and gene IDs"
    inputBinding:
      position: 101
      prefix: --prefix
  - id: translation_tab_path
    type:
      - 'null'
      - string
    doc: "Writes the translation table for old transcript IDs to new transcript IDs to the given file path"
    inputBinding:
      position: 101
      prefix: --translation_tab
  - id: out_path
    type: string
    doc: "Path to the output file"
    inputBinding:
      position: 101
      prefix: --out
outputs:
  - id: out
    type: File
    doc: "Renamed GTF file"
    outputBinding:
      glob: "$(inputs.out_path)"
  - id: translation_tab
    type:
      - 'null'
      - File
    doc: "Translation table (old to new transcript IDs)"
    outputBinding:
      glob: "$(inputs.translation_tab_path)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tsebra:1.1.2.5--pyhca03a8a_0
