cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gget
  - blast
label: gget_blast
doc: 'BLAST a nucleotide or amino acid sequence against any BLAST database.


  Tool homepage: https://github.com/pachterlab/gget'
inputs:
  - id: sequence
    type:
      - string
      - File
    doc: Sequence (str) or path to fasta file.
    inputBinding:
      position: 1
  - id: csv
    type:
      - 'null'
      - boolean
    doc: Returns results in csv format instead of json.
    inputBinding:
      position: 102
      prefix: --csv
  - id: database
    type:
      - 'null'
      - string
    doc: 'One of nt, nr, refseq_rna, refseq_protein, swissprot, pdbaa, or pdbnt. Default:
      ''nt'' for nucleotide sequences; ''nr'' for amino acid sequences.'
    inputBinding:
      position: 102
      prefix: --database
  - id: expect
    type:
      - 'null'
      - float
    doc: float or None. An expect value cutoff. Default 10.0.
    inputBinding:
      position: 102
      prefix: --expect
  - id: json
    type:
      - 'null'
      - boolean
    doc: DEPRECATED - json is now the default output format (convert to csv using
      flag [--csv]).
    inputBinding:
      position: 102
      prefix: --json
  - id: limit
    type:
      - 'null'
      - int
    doc: int or None. Limits number of hits to return. Default 50.
    inputBinding:
      position: 102
      prefix: --limit
  - id: low_comp_filt
    type:
      - 'null'
      - boolean
    doc: Turn on low complexity filter. Default off.
    inputBinding:
      position: 102
      prefix: --low_comp_filt
  - id: megablast_off
    type:
      - 'null'
      - boolean
    doc: Turn off MegaBLAST algorithm. Default on (blastn only).
    inputBinding:
      position: 102
      prefix: --megablast_off
  - id: program
    type:
      - 'null'
      - string
    doc: 'One of blastn, blastp, blastx, tblastn, or tblastx. Default: ''blastn''
      for nucleotide sequences; ''blastp'' for amino acid sequences.'
    inputBinding:
      position: 102
      prefix: --program
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not print progress information.
    inputBinding:
      position: 102
      prefix: --quiet
  - id: seq_deprecated
    type:
      - 'null'
      - string
    doc: DEPRECATED - use positional argument instead. Sequence (str) or path to fasta
      file.
    inputBinding:
      position: 102
      prefix: --sequence
  - id: out_path
    type: string
    default: results.json
    doc: Path to the file the results will be saved in, e.g. path/to/directory/results.json.
    inputBinding:
      position: 103
      prefix: --out
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: BLAST hits (JSON, or CSV with --csv).
    outputBinding:
      glob: $(inputs.out_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gget:0.29.0--pyhdfd78af_0
