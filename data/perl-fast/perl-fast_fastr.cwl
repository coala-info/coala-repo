cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastr
label: perl-fast_fastr
doc: "Transliterate or delete characters in FASTA/FASTQ sequences, identifiers, or
  descriptions.\n\nTool homepage: http://metacpan.org/pod/FAST"
inputs:
  - id: searchlist
    type:
      - 'null'
      - string
    doc: List of characters to search for
    inputBinding:
      position: 1
  - id: replacelist
    type:
      - 'null'
      - string
    doc: List of characters to replace with
    inputBinding:
      position: 2
  - id: multifasta_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input FASTA or FASTQ files
    inputBinding:
      position: 3
  - id: ambig
    type:
      - 'null'
      - string
    doc: Use <char> to replace illegal characters instead of "N" or "X" with --strict
      or --iupac
    inputBinding:
      position: 104
      prefix: --ambig
  - id: comment
    type:
      - 'null'
      - string
    doc: Include comment [string] in logfile.
    inputBinding:
      position: 104
      prefix: --comment
  - id: complement
    type:
      - 'null'
      - boolean
    doc: Character complement SEARCHLIST. The last character of REPLACELIST replaces
      all characters not in SEARCHLIST.
    inputBinding:
      position: 104
      prefix: --complement
  - id: degap
    type:
      - 'null'
      - boolean
    doc: Delete gap characters "-" from each sequence.
    inputBinding:
      position: 104
      prefix: --degap
  - id: delete
    type:
      - 'null'
      - boolean
    doc: Delete found but unreplaced characters.
    inputBinding:
      position: 104
      prefix: --delete
  - id: description_toggle
    type:
      - 'null'
      - boolean
    doc: Transliterate descriptions.
    inputBinding:
      position: 104
      prefix: --description
  - id: fastq
    type:
      - 'null'
      - boolean
    doc: Use fastq format as input and output.
    inputBinding:
      position: 104
      prefix: --fastq
  - id: format
    type:
      - 'null'
      - string
    doc: Use alternative format for input (e.g., fasta, fastq).
    inputBinding:
      position: 104
      prefix: --format
  - id: iupac
    type:
      - 'null'
      - boolean
    doc: Transliterate illegal sequence characters (including IUPAC ambiguities) to
      "N" (DNA or RNA) or "X" (protein).
    inputBinding:
      position: 104
      prefix: --iupac
  - id: log
    type:
      - 'null'
      - boolean
    doc: Creates, or appends to, a generic FAST logfile in the current working directory.
    inputBinding:
      position: 104
      prefix: --log
  - id: logname
    type:
      - 'null'
      - File
    doc: Use [string] as the name of the logfile.
    default: FAST.log.txt
    inputBinding:
      position: 104
      prefix: --logname
  - id: moltype
    type:
      - 'null'
      - string
    doc: Specify the type of sequence on input (dna|rna|protein).
    inputBinding:
      position: 104
      prefix: --moltype
  - id: no_replace
    type:
      - 'null'
      - boolean
    doc: Delete or squash characters in SEARCHLIST.
    inputBinding:
      position: 104
      prefix: --no-replace
  - id: sequence
    type:
      - 'null'
      - boolean
    doc: Transliterate sequences (identifiers by default).
    inputBinding:
      position: 104
      prefix: --sequence
  - id: squash
    type:
      - 'null'
      - boolean
    doc: Squash duplicate replaced characters.
    inputBinding:
      position: 104
      prefix: --squash
  - id: strict
    type:
      - 'null'
      - boolean
    doc: Transliterate illegal sequence characters to "N" (DNA or RNA) or "X" (protein).
    inputBinding:
      position: 104
      prefix: --strict
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-fast:1.06--pl5321hdfd78af_2
stdout: perl-fast_fastr.out
