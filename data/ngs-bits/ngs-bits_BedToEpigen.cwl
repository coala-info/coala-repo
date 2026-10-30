cwlVersion: v1.2
class: CommandLineTool
baseCommand: BedToEpigen
label: ngs-bits_BedToEpigen
doc: "Converts a modkit BED file to a Epigen TSV file.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: id_file
    type: File
    doc: "Input CSV file containing Illumina CpG IDs."
    inputBinding:
      position: 101
      prefix: -id_file
  - id: sample
    type: string
    doc: "Sample name used in output file header."
    inputBinding:
      position: 101
      prefix: -sample
  - id: input_file
    type:
      - 'null'
      - File
    doc: "Input modkit (bgzipped) BED file. If unset, read from STDIN."
    inputBinding:
      position: 101
      prefix: -in
  - id: output_file_path
    type: string
    doc: "Output FASTA file. If unset, writes to STDOUT. (This wrapper always writes to a file.)"
    inputBinding:
      position: 102
      prefix: -out
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
    doc: "Output FASTA file. If unset, writes to STDOUT. (This wrapper always writes to a file.)"
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
