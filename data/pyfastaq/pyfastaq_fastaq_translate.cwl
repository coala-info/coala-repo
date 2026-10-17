cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastaq
  - translate
label: pyfastaq_fastaq_translate
doc: "Translates all sequences in input file. Output is always FASTA format\n\nTool homepage: https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: frame
    type:
      - 'null'
      - int
    doc: "Frame to translate [0]"
    inputBinding:
      position: 1
      prefix: --frame
  - id: infile
    type: File
    doc: "Name of file to be translated"
    inputBinding:
      position: 20
  - id: outfile
    type: string
    doc: "Name of output FASTA file"
    inputBinding:
      position: 21
outputs:
  - id: output
    type: File
    doc: "Name of output FASTA file"
    outputBinding:
      glob: $(inputs.outfile)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
