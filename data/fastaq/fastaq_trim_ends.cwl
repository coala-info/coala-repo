cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastaq
  - trim_ends
label: fastaq_trim_ends
doc: "Trim fixed number of bases of start and/or end of every sequence\n\nTool homepage:
  https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: infile
    type: File
    doc: Name of input file
    inputBinding:
      position: 1
  - id: start_trim
    type: int
    doc: Number of bases to trim off start
    inputBinding:
      position: 2
  - id: end_trim
    type: int
    doc: Number of bases to trim off end
    inputBinding:
      position: 3
  - id: outfile
    type: string
    doc: Name of output file
    inputBinding:
      position: 4
outputs:
  - id: out_outfile
    type: File
    doc: Name of output file
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fastaq:v3.17.0-2-deb_cv1
