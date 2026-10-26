cwlVersion: v1.2
class: CommandLineTool
baseCommand: uvaiaball
label: uvaia_uvaiaball
doc: 'Finds all reference neighbours to query sequences within a ball radius (i.e. close to any query sequence).


  Tool homepage: https://github.com/quadram-institute-bioscience/uvaia'
inputs:
  - id: query_sequences
    type: File
    doc: aligned query sequences
    inputBinding:
      position: 1
  - id: acgt
    type:
      - 'null'
      - boolean
    doc: considers only ACGT sites (i.e. unambiguous SNP differences), more permissive and faster
    inputBinding:
      position: 101
      prefix: --acgt
  - id: keep_resolved
    type:
      - 'null'
      - boolean
    doc: when excluding redundant query seqs, keep the more resolved (instead of default, less resolved)
    inputBinding:
      position: 101
      prefix: --keep_resolved
  - id: distance
    type:
      - 'null'
      - int
    doc: ball radius, i.e. refs within this distance to any query seq are kept
    inputBinding:
      position: 101
      prefix: --distance
  - id: trim
    type:
      - 'null'
      - int
    doc: number of sites to trim from both ends (default=0, suggested for sarscov2=230)
    inputBinding:
      position: 101
      prefix: --trim
  - id: ref_ambiguity
    type:
      - 'null'
      - float
    doc: maximum allowed ambiguity for REFERENCE sequence to be excluded (default=0.5)
    inputBinding:
      position: 101
      prefix: --ref_ambiguity
  - id: query_ambiguity
    type:
      - 'null'
      - float
    doc: maximum allowed ambiguity for QUERY sequence to be excluded (default=0.5)
    inputBinding:
      position: 101
      prefix: --query_ambiguity
  - id: pool
    type:
      - 'null'
      - int
    doc: Pool size, i.e. how many sequences are queued to be processed in parallel
    inputBinding:
      position: 101
      prefix: --pool
  - id: reference
    type:
      - type: array
        items: File
    doc: aligned reference sequences (can be several files)
    inputBinding:
      position: 102
      prefix: --reference
  - id: output_path
    type:
      - 'null'
      - string
    doc: prefix of the xzipped output files
    inputBinding:
      position: 103
      prefix: --output
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output
    type:
      - 'null'
      - type: array
        items: File
    doc: output files written with the given prefix
    outputBinding:
      glob: |
        ${ return inputs.output_path ? inputs.output_path + '*' : []; }
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/uvaia:2.0.1--heee599d_3
stdout: uvaia_uvaiaball.out
