cwlVersion: v1.2
class: CommandLineTool
baseCommand: circules.py
label: mitobim_circules.py
doc: "circules - checks for circularity in nucleotide sequences. It finds duplicated
  k-mers at the ends of a single FASTA sequence, can clip the circular part, and can
  roll a circular sequence to a new start position.\n\nTool homepage: https://github.com/chrishah/MITObim"
inputs:
  - id: fasta
    type: File
    doc: fasta file containing the sequence to be evaluated.
    inputBinding:
      position: 1
      prefix: --fasta
  - id: kmer
    type:
      - 'null'
      - string
    doc: kmer size. single number (default = 31) or range (e.g. 31-35).
    inputBinding:
      position: 2
      prefix: --kmer
  - id: kmer_step
    type:
      - 'null'
      - int
    doc: kmer step size (default = 2).
    inputBinding:
      position: 3
      prefix: --kmer_step
  - id: prefix
    type:
      - 'null'
      - string
    doc: prefix for output files (default = 'circular').
    inputBinding:
      position: 4
      prefix: --prefix
  - id: extract_by_coordinates
    type:
      - 'null'
      - string
    doc: "Coordinates for clipping of sequence in format 'startpos,endpos'. Clipped
      sequence will be written to file 'prefix.circular.fasta'."
    inputBinding:
      position: 5
      prefix: --extract_by_coordinates
  - id: extract_by_length
    type:
      - 'null'
      - int
    doc: expected length (in bp) of circular molecule. If a candidate of length
      expected (+-length tolerance if specified) is found, sequence will be clipped
      and written to file 'prefix.circular.fasta'.
    inputBinding:
      position: 6
      prefix: --extract_by_length
  - id: length_tolerance_percent
    type:
      - 'null'
      - float
    doc: percent length tolerance (e.g. 0.1, for 10 %). Candidate fragments must
      have a length of 'expected length +/- t * expected length'. Default = 0.
    inputBinding:
      position: 7
      prefix: --length_tolerance_percent
  - id: length_tolerance_absolute
    type:
      - 'null'
      - int
    doc: absolute length tolerance (e.g. 1000). Candidate fragments must have a
      length of 'expected length +/- tolerance'. Default = 0.
    inputBinding:
      position: 8
      prefix: --length_tolerance_absolute
  - id: newstart_roll
    type:
      - 'null'
      - int
    doc: roll the circular sequence to this new start position.
    inputBinding:
      position: 9
      prefix: --newstart_roll
outputs:
  - id: fasta_out
    type:
      type: array
      items: File
    doc: Clipped, rolled or test FASTA files written by circules.
    outputBinding:
      glob: "*.fasta"
  - id: stdout
    type: stdout
    doc: Circularity report
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mitobim:1.9.1--hdfd78af_1
stdout: mitobim_circules.py.out
