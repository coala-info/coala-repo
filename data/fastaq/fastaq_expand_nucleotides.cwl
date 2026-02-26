cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastaq expand_nucleotides
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
outputs:
  - id: outfile
    type: File
    doc: Name of output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fastaq:v3.17.0-2-deb_cv1
