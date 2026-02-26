cwlVersion: v1.2
class: CommandLineTool
baseCommand: uvaia
label: uvaia
doc: "For every query sequence, finds closest neighbours in reference alignment.\n\
  \nTool homepage: https://github.com/quadram-institute-bioscience/uvaia"
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
    doc: considers only ACGT sites (i.e. unambiguous SNP differences) in query 
      sequences (mismatch-based)
    inputBinding:
      position: 102
      prefix: --acgt
  - id: exclude_self
    type:
      - 'null'
      - boolean
    doc: Exclude reference sequences with same name as a query sequence
    inputBinding:
      position: 102
      prefix: --exclude_self
  - id: keep_resolved
    type:
      - 'null'
      - boolean
    doc: keep more resolved and exclude redundant query seqs (default is to keep
      all)
    inputBinding:
      position: 102
      prefix: --keep_resolved
  - id: nbest
    type:
      - 'null'
      - int
    doc: number of best reference sequences per query to store
    default: 100
    inputBinding:
      position: 102
      prefix: --nbest
  - id: nthreads
    type:
      - 'null'
      - int
    doc: suggested number of threads (default is to let system decide; I may not
      honour your suggestion btw)
    inputBinding:
      position: 102
      prefix: --nthreads
  - id: pool
    type:
      - 'null'
      - int
    doc: Pool size, i.e. how many reference seqs are queued to be processed in 
      parallel (larger than number of threads, defaults to 64 per thread)
    default: 64 per thread
    inputBinding:
      position: 102
      prefix: --pool
  - id: query_ambiguity
    type:
      - 'null'
      - float
    doc: maximum allowed ambiguity for QUERY sequence to be excluded
    default: 0.5
    inputBinding:
      position: 102
      prefix: --query_ambiguity
  - id: ref_ambiguity
    type:
      - 'null'
      - float
    doc: maximum allowed ambiguity for REFERENCE sequence to be excluded
    default: 0.5
    inputBinding:
      position: 102
      prefix: --ref_ambiguity
  - id: reference
    type:
      - 'null'
      - type: array
        items: File
    doc: aligned reference sequences (can be several files)
    inputBinding:
      position: 102
      prefix: --reference
  - id: trim
    type:
      - 'null'
      - int
    doc: number of sites to trim from both ends (suggested for sarscov2=230)
    default: 0
    inputBinding:
      position: 102
      prefix: --trim
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: prefix of xzipped output alignment and table with nearest neighbour 
      sequences
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/uvaia:2.0.1--heee599d_3
