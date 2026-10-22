cwlVersion: v1.2
class: CommandLineTool
baseCommand: fasta-strip-identifier
label: taxator-tk_fasta-strip-identifier
doc: "Strip the meta-information after the first whitespace from FASTA identifiers (keeps the short unique identifier) and write the cleaned FASTA to standard output.\n\nTool homepage: https://github.com/fungs/taxator-tk"
inputs:
  - id: input_fasta
    type:
      type: array
      items: File
    doc: Input FASTA file(s)
    inputBinding:
      position: 1
outputs:
  - id: output_fasta
    type: stdout
    doc: FASTA with shortened identifiers
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxator-tk:1.3.3e--0
stdout: taxator-tk_fasta-strip-identifier.out
