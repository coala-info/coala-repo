cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastaq
  - to_fake_qual
label: pyfastaq_fastaq_to_fake_qual
doc: "Make fake quality scores file\n\nTool homepage: https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: qual
    type:
      - 'null'
      - int
    doc: "Quality score to assign to all bases [40]"
    inputBinding:
      position: 1
      prefix: --qual
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
