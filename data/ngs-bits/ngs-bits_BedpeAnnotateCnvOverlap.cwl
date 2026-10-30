cwlVersion: v1.2
class: CommandLineTool
baseCommand: BedpeAnnotateCnvOverlap
label: ngs-bits_BedpeAnnotateCnvOverlap
doc: "Annotates a SV file with (high-quality) CNV overlap of a given file.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: input_file
    type: File
    doc: "Input SV file (in BEDPE format)."
    inputBinding:
      position: 101
      prefix: -in
  - id: output_file_path
    type: string
    doc: "Output SV file (in BEDPE format)."
    inputBinding:
      position: 102
      prefix: -out
  - id: cnv
    type: File
    doc: "Input CNV file (in TSV format)."
    inputBinding:
      position: 101
      prefix: -cnv
  - id: settings
    type:
      - 'null'
      - File
    doc: "Settings override file (no other settings files are used)."
    inputBinding:
      position: 101
      prefix: --settings
outputs:
  - id: output_file
    type: File
    doc: "Output SV file (in BEDPE format)."
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
