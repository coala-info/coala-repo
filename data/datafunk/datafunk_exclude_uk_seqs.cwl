cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - datafunk
  - exclude_uk_seqs
label: datafunk_exclude_uk_seqs
doc: "exclude UK sequences from fasta\n\nTool homepage: https://github.com/cov-ert/datafunk"
inputs:
  - id: input_fasta
    type: File
    doc: Fasta file to read
    inputBinding:
      position: 101
      prefix: --input-fasta
  - id: output_fasta_path
    type: string
    doc: Output or path parameter `output_fasta_path`
    inputBinding:
      position: 102
      prefix: --output-fasta
outputs:
  - id: output_fasta
    type: File
    doc: Fasta file to write
    outputBinding:
      glob: $(inputs.output_fasta_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
