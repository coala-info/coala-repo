cwlVersion: v1.2
class: CommandLineTool
baseCommand: lordec-trim-split
label: lordec_lordec-trim-split
doc: "Scan a set of corrected long reads (in FASTA format) and output as sequence
  their regions that have indeed been corrected (which are in uppercase).\n\nTool
  homepage: http://www.atgc-montpellier.fr/lordec/"
inputs:
  - id: input_file
    type: File
    doc: FASTA-file
    inputBinding:
      position: 101
      prefix: -i
outputs:
  - id: output_file
    type: File
    doc: output-file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lordec:0.9--h77376b9_3
