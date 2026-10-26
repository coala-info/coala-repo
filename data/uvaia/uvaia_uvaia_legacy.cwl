cwlVersion: v1.2
class: CommandLineTool
baseCommand: uvaia_legacy
label: uvaia_uvaia_legacy
doc: 'Search query sequences against reference ones to describe closest ones (legacy version of uvaia).


  Tool homepage: https://github.com/quadram-institute-bioscience/uvaia'
inputs:
  - id: query_sequences
    type: File
    doc: '*aligned* sequences to search for neighbour references'
    inputBinding:
      position: 1
  - id: nbest
    type:
      - 'null'
      - int
    doc: number of best reference sequences per query to show (default=8)
    inputBinding:
      position: 101
      prefix: --nbest
  - id: nmax
    type:
      - 'null'
      - int
    doc: max number of best reference sequences when several optimal (default=2 x nbest)
    inputBinding:
      position: 101
      prefix: --nmax
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
  - id: nthreads
    type:
      - 'null'
      - int
    doc: suggested number of threads
    inputBinding:
      position: 101
      prefix: --nthreads
  - id: reference
    type: File
    doc: '*aligned* reference sequences (raw or compressed with gzip, xz, etc.)'
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
stdout: uvaia_uvaia_legacy.out
