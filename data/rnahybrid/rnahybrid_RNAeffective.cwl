cwlVersion: v1.2
class: CommandLineTool
baseCommand: RNAeffective
label: rnahybrid_RNAeffective
doc: "RNAeffective determines the effective number of orthologous miRNA targets; the number can be used to calculate more accurate joint p-values in multi-species analyses\n\nTool homepage: https://bibiserv.cebitec.uni-bielefeld.de/rnahybrid"
inputs:
  - id: query_sequence
    type:
      - 'null'
      - string
    doc: Query sequence directly (makes only sense with the -s option)
    inputBinding:
      position: 1
  - id: dinucleotide_frequencies
    type:
      - 'null'
      - File
    doc: dinucleotide frequencies file
    inputBinding:
      position: 103
      prefix: -d
  - id: helix_constraint
    type:
      - 'null'
      - string
    doc: helix constraint in the form from,to (e.g. 2,7)
    inputBinding:
      position: 103
      prefix: -f
  - id: sample_size
    type:
      - 'null'
      - int
    doc: sample size
    inputBinding:
      position: 103
      prefix: -k
  - id: length_distribution
    type:
      - 'null'
      - string
    doc: mean sequence length,std sequence length
    inputBinding:
      position: 103
      prefix: -l
  - id: max_target_length
    type:
      - 'null'
      - int
    doc: max target length
    inputBinding:
      position: 103
      prefix: -m
  - id: max_query_length
    type:
      - 'null'
      - int
    doc: max query length
    inputBinding:
      position: 103
      prefix: -n
  - id: max_internal_loop_size
    type:
      - 'null'
      - int
    doc: max internal loop size (per side)
    inputBinding:
      position: 103
      prefix: -u
  - id: max_bulge_loop_size
    type:
      - 'null'
      - int
    doc: max bulge loop size
    inputBinding:
      position: 103
      prefix: -v
  - id: randomise
    type:
      - 'null'
      - boolean
    doc: randomise queries (only with -q, without -d)
    inputBinding:
      position: 103
      prefix: -s
  - id: target_file
    type:
      - 'null'
      - File
    doc: target file in FASTA format (required)
    inputBinding:
      position: 103
      prefix: -t
  - id: query_file
    type:
      - 'null'
      - File
    doc: query file in FASTA format; used directly as a random database when given alone
    inputBinding:
      position: 103
      prefix: -q
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/rnahybrid:v2.1.2-5-deb_cv1
stdout: rnahybrid_RNAeffective.out
