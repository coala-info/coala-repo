cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastaq
  - expand_nucleotides
label: fastaq_expand_nucleotides
doc: "Makes all combinations of sequences in input file by using all possibilities
  of redundant bases. e.g. ART could be AAT or AGT. Assumes input is nucleotides,
  not amino acids\n\nTool homepage: https://github.com/sanger-pathogens/Fastaq"
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
