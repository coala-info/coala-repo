cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastaq
  - trim_Ns_at_end
label: fastaq_trim_ns_at_end
doc: "Trims any Ns off each sequence in input file. Does nothing to gaps in the middle,
  just trims the ends\n\nTool homepage: https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: infile
    type: File
    doc: Name of input file
    inputBinding:
      position: 1
  - id: outfile
    type: string
    doc: Name of output file
    inputBinding:
      position: 2
outputs:
  - id: out_outfile
    type: File
    doc: Name of output file
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fastaq:v3.17.0-2-deb_cv1
