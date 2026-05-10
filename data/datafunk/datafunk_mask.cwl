cwlVersion: v1.2
class: CommandLineTool
baseCommand: datafunk mask
label: datafunk_mask
doc: "mask regions of a fasta file using information in an external file\n\nTool homepage:
  https://github.com/cov-ert/datafunk"
inputs:
  - id: input_fasta
    type: File
    doc: Fasta file to mask
    inputBinding:
      position: 101
      prefix: --input-fasta
  - id: mask_file
    type: File
    doc: File with mask instructions to parse
    inputBinding:
      position: 101
      prefix: --mask-file
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
