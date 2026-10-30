cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastaq
  - replace_bases
label: pyfastaq_fastaq_replace_bases
doc: "Replaces all occurrences of one letter with another\n\nTool homepage: https://github.com/sanger-pathogens/Fastaq"
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
  - id: old
    type: string
    doc: "Base to be replaced"
    inputBinding:
      position: 22
  - id: new
    type: string
    doc: "Replace with this letter"
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
