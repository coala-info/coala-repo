cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phylip
  - dnadist
label: phylip_dnadist
doc: "Computes distances between sequences.\n\nTool homepage: http://evolution.genetics.washington.edu/phylip/"
inputs:
  - id: infile
    type: File
    doc: Input file containing sequences
    inputBinding:
      position: 1
  - id: outfile_path
    type: string
    doc: Output or path parameter `outfile_path`
    inputBinding:
      position: 101
      prefix: --outfile
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Output file for distances
    outputBinding:
      glob: $(inputs.outfile_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylip:3.697--h470a237_0
