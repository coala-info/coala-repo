cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastaq
  - to_boulderio
label: pyfastaq_fastaq_to_boulderio
doc: "Converts input sequence file into \"Boulder-IO\" format, which is used by primer3\n\nTool homepage: https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: infile
    type: File
    doc: "Name of input file"
    inputBinding:
      position: 20
  - id: outfile
    type: string
    doc: "Name of output files"
    inputBinding:
      position: 21
outputs:
  - id: output
    type: File
    doc: "Name of output files"
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
