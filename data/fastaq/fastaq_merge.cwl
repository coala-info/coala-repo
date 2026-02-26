cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastaq merge
label: fastaq_merge
doc: "Converts multi sequence file to a single sequence\n\nTool homepage: https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: infile
    type: File
    doc: Name of input file
    inputBinding:
      position: 1
  - id: name
    type:
      - 'null'
      - string
    doc: Name of sequence in output file
    default: union
    inputBinding:
      position: 102
      prefix: --name
outputs:
  - id: outfile
    type: File
    doc: Name of output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fastaq:v3.17.0-2-deb_cv1
