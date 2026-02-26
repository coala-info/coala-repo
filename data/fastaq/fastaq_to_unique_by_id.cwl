cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastaq_to_unique_by_id
label: fastaq_to_unique_by_id
doc: "Removes duplicate sequences from input file, based on their names. If the same\n\
  name is found more than once, then the longest sequence is kept. Order of\nsequences
  is preserved in output\n\nTool homepage: https://github.com/sanger-pathogens/Fastaq"
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
