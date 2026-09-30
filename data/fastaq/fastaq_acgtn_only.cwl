cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastaq
  - acgtn_only
label: fastaq_acgtn_only
doc: "Replaces any character that is not one of acgtACGTnN with an N\n\nTool homepage:
  https://github.com/sanger-pathogens/Fastaq"
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
outputs:
  - id: out_outfile
    type: File
    doc: Name of output file
    outputBinding:
      glob: '$(inputs.outfile)'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fastaq:v3.17.0-2-deb_cv1
