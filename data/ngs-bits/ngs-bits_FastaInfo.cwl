cwlVersion: v1.2
class: CommandLineTool
baseCommand: FastaInfo
label: ngs-bits_FastaInfo
doc: "Basic info on a FASTA file containing DNA sequences.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: "Input FASTA file. If unset, reads from STDIN."
    inputBinding:
      position: 101
      prefix: -in
  - id: output_file_path
    type: string
    doc: "Output file. If unset, writes to STDOUT. (This wrapper always writes to a file.)"
    inputBinding:
      position: 102
      prefix: -out
  - id: write_n_path
    type:
      - 'null'
      - string
    doc: "Write BED file with N base coordinates"
    inputBinding:
      position: 102
      prefix: -write_n
  - id: write_other_path
    type:
      - 'null'
      - string
    doc: "Write BED file with other base coordinates"
    inputBinding:
      position: 102
      prefix: -write_other
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
    doc: "Output file. If unset, writes to STDOUT. (This wrapper always writes to a file.)"
    outputBinding:
      glob: $(inputs.output_file_path)
  - id: write_n
    type:
      - 'null'
      - File
    doc: "Write BED file with N base coordinates"
    outputBinding:
      glob: $(inputs.write_n_path)
  - id: write_other
    type:
      - 'null'
      - File
    doc: "Write BED file with other base coordinates"
    outputBinding:
      glob: $(inputs.write_other_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
