cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cressent
  - adjust_seq
label: cressent_adjust_seq
doc: "Adjust sequences in a FASTA file to start with a specified motif.\n\nTool homepage: https://github.com/ricrocha82/cressent"
inputs:
  - id: input_fasta
    type: File
    doc: "Path to the input FASTA file."
    inputBinding:
      position: 101
      prefix: --input_fasta
  - id: output_dir
    type: string
    doc: "Path to the output directory (created by the tool; collected as the output)"
    inputBinding:
      position: 101
      prefix: --output
  - id: motif
    type:
      - 'null'
      - string
    doc: "Motif to adjust sequences to start with (default: TAGTATTAC)."
    inputBinding:
      position: 101
      prefix: --motif
outputs:
  - id: output
    type: Directory
    doc: Output directory with all result files
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cressent:1.0.2--pyhdfd78af_0
