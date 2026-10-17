cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastaq
  - trim_Ns_at_end
label: pyfastaq_fastaq_trim_Ns_at_end
doc: "Trims any Ns off each sequence in input file. Does nothing to gaps in the middle, just trims the ends\n\nTool homepage: https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: infile
    type: File
    doc: "Name of input file"
    inputBinding:
      position: 20
  - id: outfile
    type: string
    doc: "Name of output file"
    inputBinding:
      position: 21
outputs:
  - id: output
    type: File
    doc: "Name of output file"
    outputBinding:
      glob: $(inputs.outfile)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
