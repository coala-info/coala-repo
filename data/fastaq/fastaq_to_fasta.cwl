cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastaq_to_fasta
label: fastaq_to_fasta
doc: "Converts a variety of input formats to nicely formatted FASTA format\n\nTool
  homepage: https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: infile
    type: File
    doc: Name of input file. Can be any of FASTA, FASTQ, GFF3, EMBL, GBK, Phylip
    inputBinding:
      position: 1
  - id: check_unique
    type:
      - 'null'
      - boolean
    doc: Die if any of the output sequence names are not unique
    inputBinding:
      position: 102
      prefix: --check_unique
  - id: line_length
    type:
      - 'null'
      - int
    doc: Number of bases on each sequence line of output file. Set to zero for 
      no linebreaks in sequences
    inputBinding:
      position: 102
      prefix: --line_length
  - id: strip_after_whitespace
    type:
      - 'null'
      - boolean
    doc: Remove everything after first whitespace in every sequence name
    inputBinding:
      position: 102
      prefix: --strip_after_whitespace
outputs:
  - id: outfile
    type: File
    doc: Name of output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fastaq:v3.17.0-2-deb_cv1
