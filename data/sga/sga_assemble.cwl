cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sga
  - assemble
label: sga_assemble
doc: "Create contigs from the assembly graph ASQGFILE.\n\nTool homepage: https://github.com/jts/sga"
inputs:
  - id: asqgfile
    type: File
    doc: Assembly graph ASQGFILE
    inputBinding:
      position: 1
  - id: bubble
    type:
      - 'null'
      - int
    doc: perform N bubble removal steps
    inputBinding:
      position: 102
      prefix: --bubble
  - id: cut_terminal
    type:
      - 'null'
      - int
    doc: cut off terminal branches in N rounds
    inputBinding:
      position: 102
      prefix: --cut-terminal
  - id: max_divergence
    type:
      - 'null'
      - float
    doc: only remove variation if the divergence between sequences is less than 
      F
    inputBinding:
      position: 102
      prefix: --max-divergence
  - id: max_edges
    type:
      - 'null'
      - int
    doc: limit each vertex to a maximum of N edges. For highly repetitive 
      regions this helps save memory by culling excessive edges around 
      unresolvable repeats
    inputBinding:
      position: 102
      prefix: --max-edges
  - id: max_gap_divergence
    type:
      - 'null'
      - float
    doc: only remove variation if the divergence between sequences when only 
      counting indels is less than F. Setting this to 0.0 will suppress removing
      indel variation
    inputBinding:
      position: 102
      prefix: --max-gap-divergence
  - id: max_indel
    type:
      - 'null'
      - int
    doc: do not remove variation that is an indel of length greater than D
    inputBinding:
      position: 102
      prefix: --max-indel
  - id: min_branch_length
    type:
      - 'null'
      - int
    doc: remove terminal branches only if they are less than LEN bases in length
    inputBinding:
      position: 102
      prefix: --min-branch-length
  - id: min_overlap
    type:
      - 'null'
      - int
    doc: only use overlaps of at least LEN. This can be used to filter the 
      overlap set so that the overlap step only needs to be run once.
    inputBinding:
      position: 102
      prefix: --min-overlap
  - id: out_prefix
    type:
      - 'null'
      - string
    doc: use NAME as the prefix of the output files (output files will be 
      NAME-contigs.fa, etc)
    inputBinding:
      position: 102
      prefix: --out-prefix
  - id: resolve_small
    type:
      - 'null'
      - int
    doc: resolve small repeats using spanning overlaps when the difference 
      between the shortest and longest overlap is greater than LEN
    inputBinding:
      position: 102
      prefix: --resolve-small
  - id: transitive_reduction
    type:
      - 'null'
      - boolean
    doc: remove transitive edges from the graph. Off by default.
    inputBinding:
      position: 102
      prefix: --transitive-reduction
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: display verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sga:v0.10.15-4-deb_cv1
stdout: sga_assemble.out
