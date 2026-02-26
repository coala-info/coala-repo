cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastaq_to_boulderio
label: fastaq_to_boulderio
doc: "Converts input sequence file into \"Boulder-IO\" format, which is used by primer3\n\
  \nTool homepage: https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: infile
    type: File
    doc: Name of input file
    inputBinding:
      position: 1
outputs:
  - id: outfile
    type: File
    doc: Name of output files
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fastaq:v3.17.0-2-deb_cv1
