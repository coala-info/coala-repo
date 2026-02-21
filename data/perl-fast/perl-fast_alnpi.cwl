cwlVersion: v1.2
class: CommandLineTool
baseCommand: alnpi
label: perl-fast_alnpi
doc: "Calculate nucleotide diversity, Watterson estimator, or Tajima's D from multi-fasta
  alignments.\n\nTool homepage: http://metacpan.org/pod/FAST"
inputs:
  - id: multifasta_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input multi-fasta files
    inputBinding:
      position: 1
  - id: absolute
    type:
      - 'null'
      - boolean
    doc: Output a smaller set of statistics not normalized by number of gap-free sites.
    inputBinding:
      position: 102
      prefix: --absolute
  - id: comment
    type:
      - 'null'
      - string
    doc: Include comment [string] in logfile.
    inputBinding:
      position: 102
      prefix: --comment
  - id: format
    type:
      - 'null'
      - string
    doc: Use alternative format for input. Default is fasta.
    inputBinding:
      position: 102
      prefix: --format
  - id: label
    type:
      - 'null'
      - string
    doc: Text label for the input data, to be placed in the output.
    inputBinding:
      position: 102
      prefix: --label
  - id: latex
    type:
      - 'null'
      - boolean
    doc: LaTeX-style output
    inputBinding:
      position: 102
      prefix: --latex
  - id: log
    type:
      - 'null'
      - boolean
    doc: Creates, or appends to, a generic FAST logfile in the current working directory.
    inputBinding:
      position: 102
      prefix: --log
  - id: logname
    type:
      - 'null'
      - File
    doc: Use [string] as the name of the logfile.
    default: FAST.log.txt
    inputBinding:
      position: 102
      prefix: --logname
  - id: moltype
    type:
      - 'null'
      - string
    doc: Specify the type of sequence on input (dna, rna, or protein).
    inputBinding:
      position: 102
      prefix: --moltype
  - id: pairwise
    type:
      - 'null'
      - boolean
    doc: Statistics are calculated pairwise over all sequences
    inputBinding:
      position: 102
      prefix: --pairwise
  - id: suppress
    type:
      - 'null'
      - boolean
    doc: Supress header output
    inputBinding:
      position: 102
      prefix: --suppress
  - id: window
    type:
      - 'null'
      - string
    doc: Sliding window analysis. Argument expected in the form "window-size:step-size:statistic"
      where statistic is p, s, or d.
    inputBinding:
      position: 102
      prefix: --window
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-fast:1.06--pl5321hdfd78af_2
stdout: perl-fast_alnpi.out
