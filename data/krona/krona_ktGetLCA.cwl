cwlVersion: v1.2
class: CommandLineTool
baseCommand: ktGetLCA
label: krona_ktGetLCA
doc: 'Computes the lowest common ancestor for accessions or taxonomy IDs (as arguments
  or from <stdin>). If an input is a number, it is assumed to be a taxonomy ID; otherwise
  it will be considered an accession or sequence ID containing an accession in the
  fourth field of pipe notation (e.g. "gi|12345|xx|ABC123.1|", ignoring fasta/fastq
  tag markers [>,@]). If using <stdin>, the LCA can be computed for the first fields
  of all input lines (default), or per input line, separated by whitespace (see -s).


  Tool homepage: https://github.com/marbl/Krona'
inputs:
  - id: ids
    type:
      - 'null'
      - type: array
        items: string
    doc: Accessions or taxonomy IDs to compute the lowest common ancestor of. If none
      are given, the input list file is used.
    inputBinding:
      position: 1
  - id: input_list
    type:
      - 'null'
      - File
    doc: Accession or taxonomy ID list, sent to the tool as standard input. By default
      the LCA is computed for the first fields of all lines (or per line with the
      streaming option).
  - id: streaming_mode
    type:
      - 'null'
      - boolean
    doc: Streaming mode. Each line is expected to be a whitespace-separated list of
      inputs for a single lowest common ancestor computation. Taxonomy will be preloaded,
      allowing for faster computation after a small upfront time.
    inputBinding:
      position: 102
      prefix: -s
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
    doc: Taxonomy ID of the lowest common ancestor, one per line.
requirements:
  - class: InlineJavascriptRequirement
stdin: '${ return inputs.input_list ? inputs.input_list.path : null; }'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/krona:2.8.1--pl5321hdfd78af_1
stdout: krona_ktGetLCA.out
