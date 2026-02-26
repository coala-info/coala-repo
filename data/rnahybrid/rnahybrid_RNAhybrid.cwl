cwlVersion: v1.2
class: CommandLineTool
baseCommand: RNAhybrid
label: rnahybrid_RNAhybrid
doc: "RNAhybrid finds potential hybridization sites of a query RNA sequence in a target
  RNA sequence.\n\nTool homepage: https://bibiserv.cebitec.uni-bielefeld.de/rnahybrid"
inputs:
  - id: target_sequence
    type:
      - 'null'
      - string
    doc: Target sequence directly
    inputBinding:
      position: 1
  - id: query_sequence
    type:
      - 'null'
      - string
    doc: Query sequence directly
    inputBinding:
      position: 2
  - id: compact_output
    type:
      - 'null'
      - boolean
    doc: compact output
    inputBinding:
      position: 103
      prefix: -c
  - id: energy_cutoff
    type:
      - 'null'
      - float
    doc: energy cut-off
    inputBinding:
      position: 103
      prefix: -e
  - id: helix_constraint
    type:
      - 'null'
      - string
    doc: helix constraint (e.g., 'from,to')
    inputBinding:
      position: 103
      prefix: -f
  - id: max_bulge_loop_size
    type:
      - 'null'
      - int
    doc: max bulge loop size
    inputBinding:
      position: 103
      prefix: -v
  - id: max_internal_loop_size
    type:
      - 'null'
      - int
    doc: max internal loop size (per side)
    inputBinding:
      position: 103
      prefix: -u
  - id: max_query_length
    type:
      - 'null'
      - int
    doc: max query length
    inputBinding:
      position: 103
      prefix: -n
  - id: max_target_length
    type:
      - 'null'
      - int
    doc: max target length
    inputBinding:
      position: 103
      prefix: -m
  - id: num_hits_per_target
    type:
      - 'null'
      - int
    doc: number of hits per target
    inputBinding:
      position: 103
      prefix: -b
  - id: output_format
    type:
      - 'null'
      - string
    doc: Output format for graphical output (ps|png|jpg|all)
    inputBinding:
      position: 103
      prefix: -g
  - id: p_value_cutoff
    type:
      - 'null'
      - float
    doc: p-value cut-off
    inputBinding:
      position: 103
      prefix: -p
  - id: query_file
    type:
      - 'null'
      - File
    doc: Query file in FASTA format
    inputBinding:
      position: 103
      prefix: -q
  - id: sequence_type
    type:
      - 'null'
      - string
    doc: Specify sequence type for p-value estimation 
      (3utr_fly|3utr_worm|3utr_human)
    inputBinding:
      position: 103
      prefix: -s
  - id: target_file
    type:
      - 'null'
      - File
    doc: Target file in FASTA format
    inputBinding:
      position: 103
      prefix: -t
  - id: xi_theta
    type:
      - 'null'
      - string
    doc: <xi>,<theta> parameters for p-value calculation
    inputBinding:
      position: 103
      prefix: -d
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/rnahybrid:v2.1.2-5-deb_cv1
stdout: rnahybrid_RNAhybrid.out
