cwlVersion: v1.2
class: CommandLineTool
baseCommand: primalscheme multiplex
label: primalscheme_multiplex
doc: "Design a multiplex PCR scheme.\n\nTool homepage: https://github.com/aresti/primalscheme"
inputs:
  - id: fasta
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 1
  - id: amplicon_size
    type:
      - 'null'
      - int
    doc: Amplicon size target. Pass twice to set an exact range, otherwise 
      expect +/- 5.0%.
      - 380
      - 420
    inputBinding:
      position: 102
      prefix: --amplicon-size
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Set log level DEBUG.
    inputBinding:
      position: 102
      prefix: --debug
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force output to an existing directory, overwrite files.
    inputBinding:
      position: 102
      prefix: --force
  - id: high_gc
    type:
      - 'null'
      - boolean
    doc: Use config suitable for high-GC sequences.
    inputBinding:
      position: 102
      prefix: --high-gc
  - id: name
    type:
      - 'null'
      - string
    doc: Prefix name for your outputs.
    inputBinding:
      position: 102
      prefix: --name
  - id: no_debug
    type:
      - 'null'
      - boolean
    doc: Set log level DEBUG.
    inputBinding:
      position: 102
      prefix: --no-debug
  - id: no_force
    type:
      - 'null'
      - boolean
    doc: Force output to an existing directory, overwrite files.
    inputBinding:
      position: 102
      prefix: --no-force
  - id: no_high_hc
    type:
      - 'null'
      - boolean
    doc: Use config suitable for high-GC sequences.
    inputBinding:
      position: 102
      prefix: --no-high-hc
  - id: no_pinned
    type:
      - 'null'
      - boolean
    doc: Only consider primers from the first reference.
    inputBinding:
      position: 102
      prefix: --no-pinned
  - id: outpath
    type:
      - 'null'
      - Directory
    doc: Path to output directory.
    inputBinding:
      position: 102
      prefix: --outpath
  - id: pinned
    type:
      - 'null'
      - boolean
    doc: Only consider primers from the first reference.
    inputBinding:
      position: 102
      prefix: --pinned
  - id: target_overlap
    type:
      - 'null'
      - int
    doc: Target insert overlap size.
    inputBinding:
      position: 102
      prefix: --target-overlap
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/primalscheme:1.4.1--pyh7cba7a3_0
stdout: primalscheme_multiplex.out
