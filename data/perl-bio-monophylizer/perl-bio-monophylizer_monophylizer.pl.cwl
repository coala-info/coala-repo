cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - perl
  - monophylizer.pl
label: perl-bio-monophylizer_monophylizer.pl
doc: "A tool to analyze monophyly in phylogenetic trees, supporting various formats
  and metadata integration.\n\nTool homepage: https://metacpan.org/pod/Bio::Monophylizer"
inputs:
  - id: astsv
    type:
      - 'null'
      - boolean
    doc: Optional flag to set output as TSV regardless whether running as CGI. 
      This is only available when running under CGI.
    default: false
    inputBinding:
      position: 101
      prefix: -astsv
  - id: comments
    type:
      - 'null'
      - boolean
    doc: Optional flag to treat square brackets as opaque strings, not comments.
    default: true
    inputBinding:
      position: 101
      prefix: -comments
  - id: format
    type:
      - 'null'
      - string
    doc: Optional argument to specify the tree file format 
      (newick|nexus|nexml|phyloxml).
    default: newick
    inputBinding:
      position: 101
      prefix: -format
  - id: infile
    type: File
    doc: A tree file, usually in Newick format. Required.
    inputBinding:
      position: 101
      prefix: -infile
  - id: metadata
    type:
      - 'null'
      - File
    doc: Optional argument to provide the location of a tab-separated 
      spreadsheet with per-taxon metadata.
    inputBinding:
      position: 101
      prefix: -metadata
  - id: quotes
    type:
      - 'null'
      - boolean
    doc: Optional flag to treat quotes as opaque strings.
    default: true
    inputBinding:
      position: 101
      prefix: -quotes
  - id: separator
    type:
      - 'null'
      - string
    doc: Optional argument to specific the character that separates the taxon 
      name from any additional metdata in leaf labels.
    default: '|'
    inputBinding:
      position: 101
      prefix: -separator
  - id: trinomials
    type:
      - 'null'
      - boolean
    doc: Optional flag to include subspecific epithets in taxa.
    default: false
    inputBinding:
      position: 101
      prefix: -trinomials
  - id: verbose
    type:
      - 'null'
      - type: array
        items: boolean
    doc: Influences how verbose the script is. Use once for info, twice for 
      debugging.
    inputBinding:
      position: 101
      prefix: -verbose
  - id: whitespace
    type:
      - 'null'
      - boolean
    doc: Optional flag to treat whitespace as opaque strings.
    default: true
    inputBinding:
      position: 101
      prefix: -whitespace
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bio-monophylizer:1.0.0--hdfd78af_0
stdout: perl-bio-monophylizer_monophylizer.pl.out
