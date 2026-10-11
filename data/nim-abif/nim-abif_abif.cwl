cwlVersion: v1.2
class: CommandLineTool
baseCommand: abif
label: nim-abif_abif
doc: "Reads an ABIF trace file (.ab1) and exports its base calls as a FASTA file.\n\nTool
  homepage: https://github.com/quadram-institute-bioscience/nim-abif"
inputs:
  - id: trace_file
    type: File
    doc: Input ABIF trace file (.ab1)
    inputBinding:
      position: 1
  - id: output_file
    type: string
    doc: Output FASTA file
    inputBinding:
      position: 2
outputs:
  - id: fasta
    type: File
    doc: FASTA file with the base calls
    outputBinding:
      glob: $(inputs.output_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nim-abif:0.2.0--h7b50bb2_0
