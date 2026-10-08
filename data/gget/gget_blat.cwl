cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gget
  - blat
label: gget_blat
doc: 'BLAT a nucleotide or amino acid sequence against any BLAT UCSC assembly.


  Tool homepage: https://github.com/pachterlab/gget'
inputs:
  - id: sequence
    type:
      - string
      - File
    doc: Sequence (str) or path to fasta file.
    inputBinding:
      position: 1
  - id: assembly
    type:
      - 'null'
      - string
    doc: '''human'' (assembly hg38) (default), ''mouse'' (assembly mm39), or any of
      the species assemblies available at https://genome.ucsc.edu/cgi-bin/hgBlat (use
      short assembly name as listed after the ''/'').'
    inputBinding:
      position: 102
      prefix: --assembly
  - id: csv
    type:
      - 'null'
      - boolean
    doc: Returns results in csv format instead of json.
    inputBinding:
      position: 102
      prefix: --csv
  - id: json
    type:
      - 'null'
      - boolean
    doc: DEPRECATED - json is now the default output format (convert to csv using
      flag [--csv]).
    inputBinding:
      position: 102
      prefix: --json
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Does not print progress information.
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
  - id: seqtype
    type:
      - 'null'
      - string
    doc: 'One of DNA, protein, translated%20RNA, or translated%20DNA. Default: ''DNA''
      for nucleotide sequences; ''protein'' for amino acid sequences.'
    inputBinding:
      position: 102
      prefix: --seqtype
  - id: out_path
    type: string
    default: results.json
    doc: Path to the file the results will be saved in, e.g. path/to/directory/results.csv.
    inputBinding:
      position: 103
      prefix: --out
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: BLAT hits (JSON, or CSV with --csv).
    outputBinding:
      glob: $(inputs.out_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gget:0.29.0--pyhdfd78af_0
