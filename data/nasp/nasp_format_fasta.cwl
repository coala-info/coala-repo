cwlVersion: v1.2
class: CommandLineTool
baseCommand: [format_fasta]
label: nasp_format_fasta
doc: "Reformat a fasta to be split 80 characters per line, with system line-endings.\n\nTool homepage: https://github.com/TGenNorth/NASP"
inputs:
  - id: inputfasta
    type: File
    doc: "Path to input fasta."
    inputBinding:
      position: 1
      prefix: --inputfasta
  - id: outputfasta
    type: string
    doc: "Path to output fasta."
    inputBinding:
      position: 1
      prefix: --outputfasta
outputs:
  - id: formatted_fasta
    type: File
    doc: "Reformatted fasta."
    outputBinding:
      glob: $(inputs.outputfasta)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nasp:1.2.1--py37h732b199_1
