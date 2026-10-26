cwlVersion: v1.2
class: CommandLineTool
baseCommand: uvaiaclust
label: uvaia_uvaiaclust
doc: 'Cluster and dedups alignments.


  Tool homepage: https://github.com/quadram-institute-bioscience/uvaia'
inputs:
  - id: query_sequences
    type:
      - type: array
        items: File
    doc: alignments to merge
    inputBinding:
      position: 1
  - id: distance
    type:
      - 'null'
      - int
    doc: seqs with this SNP differences or less will be merged (default=1)
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
  - id: pool
    type:
      - 'null'
      - int
    doc: Pool size, i.e. number of clustering queues (should be larger than avail threads)
    inputBinding:
      position: 101
      prefix: --pool
  - id: snps
    type:
      - 'null'
      - int
    doc: how many SNPs w.r.t. reference it keeps track (default=1, should be small number)
    inputBinding:
      position: 101
      prefix: --snps
  - id: reference
    type:
      - 'null'
      - File
    doc: reference sequence (medoids are furthest from it)
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
stdout: uvaia_uvaiaclust.out
