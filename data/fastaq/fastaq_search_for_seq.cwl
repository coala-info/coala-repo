cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastaq_search_for_seq
label: fastaq_search_for_seq
doc: "Searches for an exact match on a given string and its reverse complement, in
  every sequence of input sequence file. Case insensitive. Guaranteed to find all
  hits\n\nTool homepage: https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: infile
    type: File
    doc: Name of input file
    inputBinding:
      position: 1
  - id: search_string
    type: string
    doc: String to search for in the sequences
    inputBinding:
      position: 2
outputs:
  - id: outfile
    type: File
    doc: 'Name of outputfile. Tab-delimited output: sequence name, position, strand'
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fastaq:v3.17.0-2-deb_cv1
