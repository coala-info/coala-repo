cwlVersion: v1.2
class: CommandLineTool
baseCommand: fascodon
label: perl-fast_fascodon
doc: "Calculate codon frequencies or Relative Synonymous Codon Usage (RSCU) values
  for sequences in MULTIFASTA files.\n\nTool homepage: http://metacpan.org/pod/FAST"
inputs:
  - id: multifasta_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input MULTIFASTA file(s)
    inputBinding:
      position: 1
  - id: amino_order
    type:
      - 'null'
      - string
    doc: Enumerate codons by the amino acids they encode. Determines which amino acids
      (codon families) will be analyzed and in what order.
    inputBinding:
      position: 102
      prefix: --amino-order
  - id: base_order
    type:
      - 'null'
      - string
    doc: Use bases in [string] order to enumerate codons.
    inputBinding:
      position: 102
      prefix: --base-order
  - id: code
    type:
      - 'null'
      - int
    doc: Use NCBI genetic code tableID <int> for translating sequences.
    inputBinding:
      position: 102
      prefix: --code
  - id: codes
    type:
      - 'null'
      - boolean
    doc: Output a list of NCBI genetic code tableIDs and exit.
    inputBinding:
      position: 102
      prefix: --codes
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
    doc: Use alternative format for input.
    inputBinding:
      position: 102
      prefix: --format
  - id: join
    type:
      - 'null'
      - string
    doc: Use <string> to join tagged value output in sequence record descriptions.
      Use with argument "\t" to indicate a tab-character.
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
  - id: rscu
    type:
      - 'null'
      - boolean
    doc: Output Relative Synonymous Codon Usage (RSCU) values rather than raw frequencies
      (default).
    inputBinding:
      position: 102
      prefix: --rscu
  - id: table
    type:
      - 'null'
      - boolean
    doc: Print output in a table to STDOUT.
    inputBinding:
      position: 102
      prefix: --table
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Issue warnings to STDERR about sequences with premature stop codons, that
      do not end in stop codons, sequences that are not divisible by 3, etc.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-fast:1.06--pl5321hdfd78af_2
stdout: perl-fast_fascodon.out
