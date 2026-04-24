cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastax
label: perl-fast_fastax
doc: "Filter sequences from a multi-fasta file based on taxonomic information using
  NCBI nodes and names files.\n\nTool homepage: http://metacpan.org/pod/FAST"
inputs:
  - id: nodes_file
    type:
      - 'null'
      - File
    doc: NCBI nodes.dmp file
    inputBinding:
      position: 1
  - id: names_file
    type:
      - 'null'
      - File
    doc: NCBI names.dmp file (not used in --tax-id-mode)
    inputBinding:
      position: 2
  - id: taxon
    type:
      - 'null'
      - string
    doc: Taxon name or ID to filter by
    inputBinding:
      position: 3
  - id: multifasta_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input multi-fasta file(s)
    inputBinding:
      position: 4
  - id: comment
    type:
      - 'null'
      - string
    doc: Include comment [string] in logfile.
    inputBinding:
      position: 105
      prefix: --comment
  - id: fastq
    type:
      - 'null'
      - boolean
    doc: Use fastq format as input and output.
    inputBinding:
      position: 105
      prefix: --fastq
  - id: field
    type:
      - 'null'
      - int
    doc: sequence descriptions or identifers are split into fields and field <int>
      (1-based) is searched for taxonomic identifiers
    inputBinding:
      position: 105
      prefix: --field
  - id: format
    type:
      - 'null'
      - string
    doc: Use alternative format for input.
    inputBinding:
      position: 105
      prefix: --format
  - id: identifier
    type:
      - 'null'
      - boolean
    doc: taxa are searched over sequence identifiers (default is over descriptions)
    inputBinding:
      position: 105
      prefix: --identifier
  - id: log
    type:
      - 'null'
      - boolean
    doc: Creates, or appends to, a generic FAST logfile in the current working directory.
    inputBinding:
      position: 105
      prefix: --log
  - id: logname
    type:
      - 'null'
      - string
    doc: Use [string] as the name of the logfile.
    inputBinding:
      position: 105
      prefix: --logname
  - id: moltype
    type:
      - 'null'
      - string
    doc: Specify the type of sequence on input (dna|rna|protein).
    inputBinding:
      position: 105
      prefix: --moltype
  - id: negate
    type:
      - 'null'
      - boolean
    doc: return all sequences that are not from the taxon
    inputBinding:
      position: 105
      prefix: --negate
  - id: regex_split
    type:
      - 'null'
      - string
    doc: in field-mode (-f) split on perl-regex <regex> instead of the default separator
    inputBinding:
      position: 105
      prefix: --regex-split
  - id: strict_negate
    type:
      - 'null'
      - boolean
    doc: return all sequences that are not from the taxon, but only if they are from
      a recognized taxon
    inputBinding:
      position: 105
      prefix: --strict-negate
  - id: tax_id_mode
    type:
      - 'null'
      - boolean
    doc: NCBI Taxonomic data in sequence records are numeric IDs, not names.
    inputBinding:
      position: 105
      prefix: --tax-id-mode
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-fast:1.06--pl5321hdfd78af_2
stdout: perl-fast_fastax.out
