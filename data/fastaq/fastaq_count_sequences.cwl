cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastaq count_sequences
label: fastaq_count_sequences
doc: "Prints the number of sequences in input file to stdout\n\nTool homepage: https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: infile
    type: File
    doc: Name of input file
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fastaq:v3.17.0-2-deb_cv1
stdout: fastaq_count_sequences.out
