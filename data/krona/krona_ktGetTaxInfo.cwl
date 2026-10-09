cwlVersion: v1.2
class: CommandLineTool
baseCommand: ktGetTaxInfo
label: krona_ktGetTaxInfo
doc: 'Retrieves taxonomy information for accessions or taxonomy IDs (as arguments
  or the first field of <stdin>, separated by whitespace). If the input is a number,
  it is assumed to be a taxonomy ID; otherwise it will be considered an accession
  or sequence ID containing an accession in the fourth field of pipe notation (e.g.
  "gi|12345|xx|ABC123.1|", ignoring fasta/fastq tag markers [>,@]). If taxonomy information
  was not found for a given input line, the output line will be only the taxonomy
  ID, which will be 0 if it was looked up from an accession but not found. Output
  fields are: taxID, depth, parent, rank, name.


  Tool homepage: https://github.com/marbl/Krona'
inputs:
  - id: ids
    type:
      - 'null'
      - type: array
        items: string
    doc: Accessions or taxonomy IDs to look up. If none are given, the input list
      file is used.
    inputBinding:
      position: 1
  - id: input_list
    type:
      - 'null'
      - File
    doc: Accession or taxonomy ID list, sent to the tool as standard input.
  - id: append_tax_info
    type:
      - 'null'
      - boolean
    doc: Append tax info to the original lines (separated by tabs).
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
    doc: Prepend tax info to the original lines (separated by tabs).
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
    doc: 'Taxonomy information, one line per input: taxID, depth, parent, rank, name.'
requirements:
  - class: InlineJavascriptRequirement
stdin: '${ return inputs.input_list ? inputs.input_list.path : null; }'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/krona:2.8.1--pl5321hdfd78af_1
stdout: krona_ktGetTaxInfo.out
