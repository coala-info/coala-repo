cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastaq
  - interleave
label: pyfastaq_fastaq_interleave
doc: "Interleaves two files, output is alternating between fwd/rev reads\n\nTool homepage: https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: suffix1
    type:
      - 'null'
      - string
    doc: "Suffix to add to all names from infile_1 (if suffix not already present)"
    inputBinding:
      position: 1
      prefix: --suffix1
  - id: suffix2
    type:
      - 'null'
      - string
    doc: "Suffix to add to all names from infile_2 (if suffix not already present)"
    inputBinding:
      position: 2
      prefix: --suffix2
  - id: infile_1
    type: File
    doc: "Name of first input file"
    inputBinding:
      position: 20
  - id: infile_2
    type: File
    doc: "Name of second input file"
    inputBinding:
      position: 21
  - id: outfile
    type: string
    doc: "Name of output file of interleaved reads"
    inputBinding:
      position: 22
outputs:
  - id: output
    type: File
    doc: "Name of output file of interleaved reads"
    outputBinding:
      glob: $(inputs.outfile)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
