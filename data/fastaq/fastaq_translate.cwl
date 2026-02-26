cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastaq translate
label: fastaq_translate
doc: "Translates all sequences in input file. Output is always FASTA format\n\nTool
  homepage: https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: infile
    type: File
    doc: Name of file to be translated
    inputBinding:
      position: 1
  - id: frame
    type:
      - 'null'
      - int
    doc: Frame to translate
    default: 0
    inputBinding:
      position: 102
      prefix: --frame
outputs:
  - id: outfile
    type: File
    doc: Name of output FASTA file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fastaq:v3.17.0-2-deb_cv1
