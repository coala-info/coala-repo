cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastaq
  - to_fake_qual
label: fastaq_to_fake_qual
doc: "Make fake quality scores file\n\nTool homepage: https://github.com/sanger-pathogens/Fastaq"
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
  - id: qual
    type:
      - 'null'
      - int
    doc: Quality score to assign to all bases
    inputBinding:
      position: 102
      prefix: --qual
outputs:
  - id: out_outfile
    type: File
    doc: Name of output file
    outputBinding:
      glob: '$(inputs.outfile)'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fastaq:v3.17.0-2-deb_cv1
