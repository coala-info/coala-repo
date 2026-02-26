cwlVersion: v1.2
class: CommandLineTool
baseCommand: make_prg update
label: make_prg_update
doc: "Updates a PRG database with new sequences.\n\nTool homepage: https://github.com/rmcolq/make_prg"
inputs:
  - id: denovo_paths
    type:
      - 'null'
      - File
    doc: Filepath containing denovo sequences. Should point to a 
      denovo_paths.txt file
    inputBinding:
      position: 101
      prefix: --denovo-paths
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwrite previous output
    inputBinding:
      position: 101
      prefix: --force
  - id: log
    type:
      - 'null'
      - File
    doc: Path to write log to. Default is stderr
    inputBinding:
      position: 101
      prefix: --log
  - id: long_deletion_threshold
    type:
      - 'null'
      - int
    doc: Ignores long deletions of the given size or longer. If long deletions 
      should not be ignored, put a large value.
    default: 10
    inputBinding:
      position: 101
      prefix: --deletion-threshold
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Prefix for the output files
    inputBinding:
      position: 101
      prefix: --output-prefix
  - id: output_type
    type:
      - 'null'
      - string
    doc: 'p: PRG, b: Binary, g: GFA, a: All. Combinations are allowed i.e., gb: GFA
      and Binary.'
    default: a
    inputBinding:
      position: 101
      prefix: --output-type
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads. 0 will use all available.
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: update_ds
    type:
      - 'null'
      - File
    doc: Filepath to the update data structures (a *.update_DS.zip file created 
      from make_prg from_msa or update)
    inputBinding:
      position: 101
      prefix: --update-DS
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase output verbosity (-v for debug, -vv for trace - trace is for 
      developers only)
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/make_prg:0.5.0--pyhdfd78af_0
stdout: make_prg_update.out
