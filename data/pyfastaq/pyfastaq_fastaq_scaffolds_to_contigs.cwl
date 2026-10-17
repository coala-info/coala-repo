cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastaq
  - scaffolds_to_contigs
label: pyfastaq_fastaq_scaffolds_to_contigs
doc: "Creates a file of contigs from a file of scaffolds - i.e. breaks at every gap in the input\n\nTool homepage: https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: number_contigs
    type:
      - 'null'
      - boolean
    doc: "Use this to enumerate contig names 1,2,3,... within each scaffold"
    inputBinding:
      position: 1
      prefix: --number_contigs
  - id: infile
    type: File
    doc: "Name of input file"
    inputBinding:
      position: 20
  - id: outfile
    type: string
    doc: "Name of output contigs file"
    inputBinding:
      position: 21
outputs:
  - id: output
    type: File
    doc: "Name of output contigs file"
    outputBinding:
      glob: $(inputs.outfile)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
