cwlVersion: v1.2
class: CommandLineTool
baseCommand: diprofile
label: dnp-diprofile
doc: "This program computes a profile of a frequency of occurrence of the dinucleotide
  in a batch of fasta sequences aligned by their start position.\n\nTool homepage:
  https://github.com/erinijapranckeviciene/dnpatterntools"
inputs:
  - id: fasta_file
    type: File
    doc: FASTA_FILE STRING
    inputBinding:
      position: 1
  - id: complement
    type:
      - 'null'
      - boolean
    doc: Perform computation on COMPLEMENTARY sequences of the strings in fasta 
      file.
    inputBinding:
      position: 102
      prefix: --complement
  - id: dinucleotide
    type:
      - 'null'
      - string
    doc: Dinucleotide to compute a frequency profile in fasta file. One of AA, 
      AC, AG, AT, CA, CC, CG, CT, GA, GC, GG, GT, TA, TC, TG, and TT.
    inputBinding:
      position: 102
      prefix: --dinucleotide
  - id: seqlength
    type:
      - 'null'
      - int
    doc: Sequence length in fasta file. In range [25..600].
    inputBinding:
      position: 102
      prefix: --seqlength
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print parameters and variables.
    inputBinding:
      position: 102
      prefix: --verbose
  - id: version_check
    type:
      - 'null'
      - boolean
    doc: Turn this option off to disable version update notifications of the 
      application. One of 1, ON, TRUE, T, YES, 0, OFF, FALSE, F, and NO.
    inputBinding:
      position: 102
      prefix: --version-check
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dnp-diprofile:1.0--hd6d6fdc_7
stdout: dnp-diprofile.out
