cwlVersion: v1.2
class: CommandLineTool
baseCommand: fasxl
label: perl-fast_fasxl
doc: "Translate nucleotide sequences to amino acids in FASTA/FASTQ files.\n\nTool
  homepage: http://metacpan.org/pod/FAST"
inputs:
  - id: multifasta_file
    type:
      - 'null'
      - type: array
        items: File
    doc: Input FASTA or FASTQ files
    inputBinding:
      position: 1
  - id: annotate
    type:
      - 'null'
      - boolean
    doc: Outputs translations as tagged values in descriptions instead of in the sequence.
    inputBinding:
      position: 102
      prefix: --annotate
  - id: cds
    type:
      - 'null'
      - boolean
    doc: Treat as CDS (e.g., treat init codons as M). Deprecated.
    inputBinding:
      position: 102
      prefix: --cds
  - id: code
    type:
      - 'null'
      - int
    doc: Use NCBI genetic code tableID <int> for translating sequences.
    inputBinding:
      position: 102
      prefix: --code
  - id: codon2aa
    type:
      - 'null'
      - boolean
    doc: Turn codon alignment into a protein alignment.
    inputBinding:
      position: 102
      prefix: --codon2aa
  - id: comment
    type:
      - 'null'
      - string
    doc: Include comment [string] in logfile.
    inputBinding:
      position: 102
      prefix: --comment
  - id: fastq
    type:
      - 'null'
      - boolean
    doc: Use fastq format as input and output.
    inputBinding:
      position: 102
      prefix: --fastq
  - id: format
    type:
      - 'null'
      - string
    doc: Use alternative format for input (e.g., fasta, fastq).
    default: fasta
    inputBinding:
      position: 102
      prefix: --format
  - id: frame
    type:
      - 'null'
      - int
    doc: Specify the frame for translation [0,1,2].
    default: 0
    inputBinding:
      position: 102
      prefix: --frame
  - id: gapped
    type:
      - 'null'
      - boolean
    doc: Enables translation of gapped sequences.
    inputBinding:
      position: 102
      prefix: --gapped
  - id: join
    type:
      - 'null'
      - string
    doc: Use a <string> to join data in the description. Default is a space character.
    default: ' '
    inputBinding:
      position: 102
      prefix: --join
  - id: keep
    type:
      - 'null'
      - boolean
    doc: Keep inputted sequences in the output. Also enables translation of gapped
      sequences.
    inputBinding:
      position: 102
      prefix: --keep
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
      - string
    doc: Use [string] as the name of the logfile.
    default: FAST.log.txt
    inputBinding:
      position: 102
      prefix: --logname
  - id: stop
    type:
      - 'null'
      - string
    doc: Specify a string representing stop codons.
    default: '*'
    inputBinding:
      position: 102
      prefix: --stop
  - id: tables
    type:
      - 'null'
      - boolean
    doc: Output a list of NCBI genetic code tableIDs and exit.
    inputBinding:
      position: 102
      prefix: --tables
  - id: translate_3_frames
    type:
      - 'null'
      - boolean
    doc: Translate each sequence in all three forward frames.
    inputBinding:
      position: 102
      prefix: '-3'
  - id: translate_6_frames
    type:
      - 'null'
      - boolean
    doc: Translate each sequence in all six frames.
    inputBinding:
      position: 102
      prefix: '-6'
  - id: unknown
    type:
      - 'null'
      - string
    doc: Specify a string representing unknown amino acids.
    default: X
    inputBinding:
      position: 102
      prefix: --unknown
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-fast:1.06--pl5321hdfd78af_2
stdout: perl-fast_fasxl.out
