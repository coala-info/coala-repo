cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastaq
  - search_for_seq
label: pyfastaq_fastaq_search_for_seq
doc: "Searches for an exact match on a given string and its reverse complement, in every sequence of input sequence file. Case insensitive. Guaranteed to find all hits\n\nTool homepage: https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: infile
    type: File
    doc: "Name of input file"
    inputBinding:
      position: 20
  - id: outfile
    type: string
    doc: "Name of outputfile. Tab-delimited output: sequence name, position, strand"
    inputBinding:
      position: 21
  - id: search_string
    type: string
    doc: "String to search for in the sequences"
    inputBinding:
      position: 22
outputs:
  - id: output
    type: File
    doc: "Name of outputfile. Tab-delimited output: sequence name, position, strand"
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
