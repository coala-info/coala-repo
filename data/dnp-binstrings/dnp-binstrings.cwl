cwlVersion: v1.2
class: CommandLineTool
baseCommand: binstrings
label: dnp-binstrings
doc: "This program reads the fasta file and each sequence is transformed into\n  \
  \  0011 form in which ones denotedinucleotides and zeros are elsewhere.Binary\n\
  \    sequence is printed. The last lneis the profile of the dinucleotide\n    appearance.\n\
  \nTool homepage: https://github.com/erinijapranckeviciene/dnpatterntools"
inputs:
  - id: fasta_file
    type: File
    doc: FASTA_FILE STRING
    inputBinding:
      position: 1
  - id: dinucleotide
    type:
      - 'null'
      - string
    doc: "Dinucleotide that is to identify in fasta sequences One of AA, AC,\n   \
      \       AG, AT, CA, CC, CG, CT, GA, GC, GG, GT, TA, TC, TG, and TT."
    default: CC
    inputBinding:
      position: 102
      prefix: --dinucleotide
  - id: version_check
    type:
      - 'null'
      - boolean
    doc: "Turn this option off to disable version update notifications of the\n  \
      \        application. One of 1, ON, TRUE, T, YES, 0, OFF, FALSE, F, and NO."
    default: 1
    inputBinding:
      position: 102
      prefix: --version-check
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dnp-binstrings:1.0--hd6d6fdc_6
stdout: dnp-binstrings.out
