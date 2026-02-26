cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastaq
  - strip_illumina_suffix
label: fastaq_strip_illumina_suffix
doc: "Strips /1 or /2 off the end of every read name\n\nTool homepage: https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: infile
    type: File
    doc: Name of input file
    inputBinding:
      position: 1
outputs:
  - id: outfile
    type: File
    doc: Name of output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fastaq:v3.17.0-2-deb_cv1
