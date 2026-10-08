cwlVersion: v1.2
class: CommandLineTool
baseCommand: fasta_windows
label: fasta_windows
doc: "Quickly compute statistics over a fasta file in windows.\n\nTool homepage: https://github.com/tolkit/fasta_windows"
inputs:
  - id: fasta
    type: File
    doc: The input fasta file.
    inputBinding:
      prefix: --fasta
  - id: output
    type: string
    doc: Output filename for the TSV's (without extension).
    inputBinding:
      prefix: --output
  - id: description
    type:
      - 'null'
      - boolean
    doc: Add an extra column to _windows.tsv output with fasta header descriptions.
    inputBinding:
      prefix: --description
  - id: masked
    type:
      - 'null'
      - boolean
    doc: Consider only uppercase nucleotides in the calculations.
    inputBinding:
      prefix: --masked
  - id: window_size
    type:
      - 'null'
      - int
    doc: Integer size of window for statistics to be computed over. [default 1000]
    inputBinding:
      prefix: --window_size
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: TSV files written to the fw_out directory with the prefix given in output
    outputBinding:
      glob: fw_out/$(inputs.output)*.tsv
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fasta_windows:0.2.4--h7b50bb2_4
