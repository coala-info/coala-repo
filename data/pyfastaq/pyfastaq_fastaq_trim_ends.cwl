cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastaq
  - trim_ends
label: pyfastaq_fastaq_trim_ends
doc: "Trim fixed number of bases of start and/or end of every sequence\n\nTool homepage: https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: infile
    type: File
    doc: "Name of input file"
    inputBinding:
      position: 20
  - id: start_trim
    type: int
    doc: "Number of bases to trim off start"
    inputBinding:
      position: 21
  - id: end_trim
    type: int
    doc: "Number of bases to trim off end"
    inputBinding:
      position: 22
  - id: outfile
    type: string
    doc: "Name of output file"
    inputBinding:
      position: 23
outputs:
  - id: output
    type: File
    doc: "Name of output file"
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
