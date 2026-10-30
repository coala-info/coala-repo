cwlVersion: v1.2
class: CommandLineTool
baseCommand: VcfToBed
label: ngs-bits_VcfToBed
doc: "Converts a VCF file to a BED file. For SNVs exactly one base is in the output region. For insertions the base before and after the insertion is contained. For deletions the base before the deletion and all deleted bases are contained.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: add_chr
    type:
      - 'null'
      - boolean
    doc: "Add 'chr' to chromosome names if missing."
    inputBinding:
      position: 1
      prefix: -add_chr
  - id: input_file
    type:
      - 'null'
      - File
    doc: "Input variant list in VCF format."
    inputBinding:
      position: 2
      prefix: -in
  - id: output_path
    type:
      - 'null'
      - string
    doc: "Output region in BED format."
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
    type:
      - 'null'
      - File
    doc: "Output region in BED format."
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
