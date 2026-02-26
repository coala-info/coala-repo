cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastaq_interleave
label: fastaq_interleave
doc: "Interleaves two files, output is alternating between fwd/rev reads\n\nTool homepage:
  https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: infile_1
    type: File
    doc: Name of first input file
    inputBinding:
      position: 1
  - id: infile_2
    type: File
    doc: Name of second input file
    inputBinding:
      position: 2
  - id: suffix1
    type:
      - 'null'
      - string
    doc: Suffix to add to all names from infile_1 (if suffix not already 
      present)
    inputBinding:
      position: 103
      prefix: --suffix1
  - id: suffix2
    type:
      - 'null'
      - string
    doc: Suffix to add to all names from infile_2 (if suffix not already 
      present)
    inputBinding:
      position: 103
      prefix: --suffix2
outputs:
  - id: outfile
    type: File
    doc: Name of output file of interleaved reads
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fastaq:v3.17.0-2-deb_cv1
