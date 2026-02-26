cwlVersion: v1.2
class: CommandLineTool
baseCommand: snpgenie_gtf2revcom.pl
label: snpgenie_gtf2revcom.pl
doc: "Converts a '+' strand GTF file to its reverse complement representation.\n\n\
  Tool homepage: https://github.com/chasewnelson/SNPGenie"
inputs:
  - id: gtf_file
    type: File
    doc: A '+' strand GTF file containing both '+' and '–' strand products from 
      the '+' strand point of view.
    inputBinding:
      position: 1
  - id: sequence_length
    type: int
    doc: The total sequence length.
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snpgenie:1.0--hdfd78af_1
stdout: snpgenie_gtf2revcom.pl.out
