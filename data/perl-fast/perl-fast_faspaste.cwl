cwlVersion: v1.2
class: CommandLineTool
baseCommand: faspaste
label: perl-fast_faspaste
doc: "Concatenate data from multiple FASTA files.\n\nTool homepage: http://metacpan.org/pod/FAST"
inputs:
  - id: multifasta_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input MULTIFASTA files
    inputBinding:
      position: 1
  - id: comment
    type:
      - 'null'
      - string
    doc: Include comment [string] in logfile. No comment is saved by default.
    inputBinding:
      position: 102
      prefix: --comment
  - id: description
    type:
      - 'null'
      - boolean
    doc: Concatenate descriptions. The default join-string is a single space characer.
    inputBinding:
      position: 102
      prefix: --description
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
    doc: Use alternative format for input. See man page for "fasconvert" for allowed
      formats.
    default: fasta
    inputBinding:
      position: 102
      prefix: --format
  - id: identifier
    type:
      - 'null'
      - boolean
    doc: Concatenate identifiers. The default join-string is the empty string.
    inputBinding:
      position: 102
      prefix: --identifier
  - id: join
    type:
      - 'null'
      - string
    doc: Use <string> to concatenate data. Use "\t" to indicate a tab-character.
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
    default: FAST.log.txt
    inputBinding:
      position: 102
      prefix: --logname
  - id: recipient
    type:
      - 'null'
      - int
    doc: 'Use input source #<int> as template to receive concatenated data. One-based
      indexing is used, with input source 1 as default.'
    default: 1
    inputBinding:
      position: 102
      prefix: --recipient
  - id: repeat
    type:
      - 'null'
      - boolean
    doc: Once records are exhausted from any source, repeat the last entry from that
      source in subsequent operations.
    inputBinding:
      position: 102
      prefix: --repeat
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-fast:1.06--pl5321hdfd78af_2
stdout: perl-fast_faspaste.out
