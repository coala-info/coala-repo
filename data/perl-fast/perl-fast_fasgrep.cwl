cwlVersion: v1.2
class: CommandLineTool
baseCommand: fasgrep
label: perl-fast_fasgrep
doc: "Search for records in FASTA files using Perl regular expressions against sequences
  or descriptions.\n\nTool homepage: http://metacpan.org/pod/FAST"
inputs:
  - id: perl_regex
    type:
      - 'null'
      - string
    doc: Perl regular expression to match against
    inputBinding:
      position: 1
  - id: multifasta_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input FASTA file(s)
    inputBinding:
      position: 2
  - id: comment
    type:
      - 'null'
      - string
    doc: Include comment [string] in logfile.
    inputBinding:
      position: 103
      prefix: --comment
  - id: description
    type:
      - 'null'
      - boolean
    doc: Print records whose descriptions match the regex.
    inputBinding:
      position: 103
      prefix: --description
  - id: fastq
    type:
      - 'null'
      - boolean
    doc: Use fastq format as input and output.
    inputBinding:
      position: 103
      prefix: -q
  - id: field
    type:
      - 'null'
      - int
    doc: Split descriptions into fields, and print records for which a specific numbered
      field matches the regex.
    inputBinding:
      position: 103
      prefix: --field
  - id: format
    type:
      - 'null'
      - string
    doc: Use alternative format for input (default is fasta).
    inputBinding:
      position: 103
      prefix: --format
  - id: insensitive
    type:
      - 'null'
      - boolean
    doc: Match data case-insensitively.
    inputBinding:
      position: 103
      prefix: --insensitive
  - id: iupac_expand_nuc
    type:
      - 'null'
      - boolean
    doc: Expand IUPAC ambiguity symbols in the regex argument for DNA/RNA sequence
      matching (implies -s).
    inputBinding:
      position: 103
      prefix: --iupac-expand-nuc
  - id: iupac_expand_prot
    type:
      - 'null'
      - boolean
    doc: Expand IUPAC ambiguity symbols in the regex argument for protein sequence
      matching (implies -s).
    inputBinding:
      position: 103
      prefix: --iupac-expand-prot
  - id: log
    type:
      - 'null'
      - boolean
    doc: Creates, or appends to, a generic FAST logfile in the current working directory.
    inputBinding:
      position: 103
      prefix: --log
  - id: logname
    type:
      - 'null'
      - string
    doc: Use [string] as the name of the logfile.
    inputBinding:
      position: 103
      prefix: --logname
  - id: moltype
    type:
      - 'null'
      - string
    doc: Specify the type of sequence on input (dna, rna, or protein).
    inputBinding:
      position: 103
      prefix: --moltype
  - id: negate
    type:
      - 'null'
      - boolean
    doc: Output sequences that do not match the regular expression argument.
    inputBinding:
      position: 103
      prefix: --negate
  - id: revcom_iupac_expand_nuc
    type:
      - 'null'
      - boolean
    doc: Reverse complement the regular-expression and expand IUPAC ambiguity symbols
      for DNA/RNA sequence matching (implies -s).
    inputBinding:
      position: 103
      prefix: --revcom-iupac-expand-nuc
  - id: sequence
    type:
      - 'null'
      - boolean
    doc: Print records whose sequence data match the regex.
    inputBinding:
      position: 103
      prefix: --sequence
  - id: split_on_regex
    type:
      - 'null'
      - string
    doc: Use regex to split the description for the -f option instead of whitespace.
    inputBinding:
      position: 103
      prefix: --split-on-regex
  - id: tag
    type:
      - 'null'
      - string
    doc: Query sequence records by values of a named tag in the description (e.g.,
      name:value or name=value).
    inputBinding:
      position: 103
      prefix: --tag
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-fast:1.06--pl5321hdfd78af_2
stdout: perl-fast_fasgrep.out
