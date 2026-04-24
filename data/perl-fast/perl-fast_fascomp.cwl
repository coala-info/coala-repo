cwlVersion: v1.2
class: CommandLineTool
baseCommand: fascomp
label: perl-fast_fascomp
doc: "Compute character frequencies or relative frequencies for sequences in FASTA
  files.\n\nTool homepage: http://metacpan.org/pod/FAST"
inputs:
  - id: multifasta_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input FASTA files to process
    inputBinding:
      position: 1
  - id: alphabet
    type:
      - 'null'
      - string
    doc: Tally only characters if they are in the set <string>, as in "ACGT-".
    inputBinding:
      position: 102
      prefix: --alphabet
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
    doc: use fastq format as input and output.
    inputBinding:
      position: 102
      prefix: --fastq
  - id: format
    type:
      - 'null'
      - string
    doc: Use alternative format for input. See man page for "fasconvert" for allowed
      formats.
    inputBinding:
      position: 102
      prefix: --format
  - id: iupac
    type:
      - 'null'
      - boolean
    doc: Output character header including ambiguities for table-mode.
    inputBinding:
      position: 102
      prefix: --iupac
  - id: join
    type:
      - 'null'
      - string
    doc: Use <string> to join tagged values in descriptions. Use "\t" to indicate
      a tab-character.
    inputBinding:
      position: 102
      prefix: --join
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
    inputBinding:
      position: 102
      prefix: --logname
  - id: moltype
    type:
      - 'null'
      - string
    doc: Specify the type of sequence on input (dna|rna|protein).
    inputBinding:
      position: 102
      prefix: --moltype
  - id: normalize
    type:
      - 'null'
      - boolean
    doc: Compute relative frequencies.
    inputBinding:
      position: 102
      prefix: --normalize
  - id: precision
    type:
      - 'null'
      - int
    doc: Print relative frequencies with <int> digits after the decimal point.
    inputBinding:
      position: 102
      prefix: --precision
  - id: strict
    type:
      - 'null'
      - boolean
    doc: Output moltype-dependent character header for table-mode.
    inputBinding:
      position: 102
      prefix: --strict
  - id: table
    type:
      - 'null'
      - boolean
    doc: Output a table to STDOUT.
    inputBinding:
      position: 102
      prefix: --table
  - id: width
    type:
      - 'null'
      - int
    doc: Print frequencies in fields of width <int>
    inputBinding:
      position: 102
      prefix: --width
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-fast:1.06--pl5321hdfd78af_2
stdout: perl-fast_fascomp.out
