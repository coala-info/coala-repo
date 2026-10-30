cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastaq
  - merge
label: pyfastaq_fastaq_merge
doc: "Converts multi sequence file to a single sequence\n\nTool homepage: https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: name
    type:
      - 'null'
      - string
    doc: "Name of sequence in output file [union]"
    inputBinding:
      position: 1
      prefix: --name
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
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
