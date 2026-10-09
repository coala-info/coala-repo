cwlVersion: v1.2
class: CommandLineTool
baseCommand: ktGetTaxIDFromAcc
label: krona_ktGetTaxIDFromAcc
doc: 'Translates accessions (from arguments or <stdin>) to NCBI taxonomy IDs. The
  accession can be bare or in the fourth field of pipe notation (e.g. "gi|12345|xx|ABC123.1|",
  ignoring fasta tag markers [">"]). Inputs that are bare numbers will be assumed
  to be taxonomy IDs already and preserved. Accessions with no taxonomy IDs in the
  database will return 0.


  Tool homepage: https://github.com/marbl/Krona'
inputs:
  - id: ids
    type:
      - 'null'
      - type: array
        items: string
    doc: Accessions to translate to taxonomy IDs. If none are given, the input list
      file is used.
    inputBinding:
      position: 1
  - id: input_list
    type:
      - 'null'
      - File
    doc: Accession list, sent to the tool as standard input.
  - id: append_tax_info
    type:
      - 'null'
      - boolean
    doc: Append tax IDs to the original lines (separated by tabs).
    inputBinding:
      position: 102
      prefix: -a
  - id: field_of_accessions
    type:
      - 'null'
      - int
    doc: Field of accessions.
    inputBinding:
      position: 102
      prefix: -f
  - id: prepend_tax_info
    type:
      - 'null'
      - boolean
    doc: Prepend tax IDs to the original lines (separated by tabs).
    inputBinding:
      position: 102
      prefix: -p
  - id: taxonomy_database_path
    type:
      - 'null'
      - Directory
    doc: Path to directory containing a taxonomy database to use.
    inputBinding:
      position: 102
      prefix: -tax
outputs:
  - id: stdout
    type: stdout
    doc: Taxonomy IDs, one per input.
requirements:
  - class: InlineJavascriptRequirement
stdin: '${ return inputs.input_list ? inputs.input_list.path : null; }'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/krona:2.8.1--pl5321hdfd78af_1
stdout: krona_ktGetTaxIDFromAcc.out
