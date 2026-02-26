cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastaq_scaffolds_to_contigs
label: fastaq_scaffolds_to_contigs
doc: "Creates a file of contigs from a file of scaffolds - i.e. breaks at every gap\n\
  in the input\n\nTool homepage: https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: infile
    type: File
    doc: Name of input file
    inputBinding:
      position: 1
  - id: number_contigs
    type:
      - 'null'
      - boolean
    doc: "Use this to enumerate contig names 1,2,3,... within each\n             \
      \       scaffold"
    inputBinding:
      position: 102
      prefix: --number_contigs
outputs:
  - id: outfile
    type: File
    doc: Name of output contigs file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fastaq:v3.17.0-2-deb_cv1
