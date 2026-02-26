cwlVersion: v1.2
class: CommandLineTool
baseCommand: locidex_format
label: locidex_format
doc: "Format fasta files from other MLST databases for use with locidex build\n\n\
  Tool homepage: https://pypi.org/project/locidex/"
inputs:
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite existing directory
    inputBinding:
      position: 101
      prefix: --force
  - id: input
    type: Directory
    doc: Input directory of fasta files or input fasta
    inputBinding:
      position: 101
      prefix: --input
  - id: max_len_frac
    type:
      - 'null'
      - float
    doc: Used to calculate individual sequence maximimum acceptable length (1 - 
      n)
    inputBinding:
      position: 101
      prefix: --max_len_frac
  - id: min_ident
    type:
      - 'null'
      - float
    doc: Global minumum percent identity required for match
    inputBinding:
      position: 101
      prefix: --min_ident
  - id: min_len_frac
    type:
      - 'null'
      - float
    doc: Used to calculate individual sequence minimum acceptable length (0 - 1)
    inputBinding:
      position: 101
      prefix: --min_len_frac
  - id: min_match_cov
    type:
      - 'null'
      - float
    doc: Global minumum percent hit coverage identity required for match
    inputBinding:
      position: 101
      prefix: --min_match_cov
  - id: not_coding
    type:
      - 'null'
      - boolean
    doc: Skip translation
    inputBinding:
      position: 101
      prefix: --not_coding
  - id: translation_table
    type:
      - 'null'
      - Directory
    doc: output directory
    inputBinding:
      position: 101
      prefix: --translation_table
outputs:
  - id: outdir
    type: Directory
    doc: Output directory to put results
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/locidex:0.4.0--pyhdfd78af_0
