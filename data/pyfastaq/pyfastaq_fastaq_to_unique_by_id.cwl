cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastaq
  - to_unique_by_id
label: pyfastaq_fastaq_to_unique_by_id
doc: "Removes duplicate sequences from input file, based on their names. If the same name is found more than once, then the longest sequence is kept. Order of sequences is preserved in output\n\nTool homepage: https://github.com/sanger-pathogens/Fastaq"
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
