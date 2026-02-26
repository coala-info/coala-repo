cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - datafunk
  - sam_2_fasta
label: datafunk_sam_2_fasta
doc: "aligned sam -> fasta (with optional trim to user-defined (reference) co-ordinates)\n\
  \nTool homepage: https://github.com/cov-ert/datafunk"
inputs:
  - id: log_all_deletions
    type:
      - 'null'
      - boolean
    doc: log all (including singleton) deletions relative to the reference
    inputBinding:
      position: 101
      prefix: --log-all-deletions
  - id: log_all_inserts
    type:
      - 'null'
      - boolean
    doc: log all (including singleton) insertions relative to the reference
    inputBinding:
      position: 101
      prefix: --log-all-inserts
  - id: log_deletions
    type:
      - 'null'
      - boolean
    doc: log non-singleton deletions relative to the reference
    inputBinding:
      position: 101
      prefix: --log-deletions
  - id: log_inserts
    type:
      - 'null'
      - boolean
    doc: log non-singleton insertions relative to the reference
    inputBinding:
      position: 101
      prefix: --log-inserts
  - id: pad
    type:
      - 'null'
      - boolean
    doc: if --trim, pad trimmed ends with Ns, to retain reference length
    inputBinding:
      position: 101
      prefix: --pad
  - id: prefix_ref
    type:
      - 'null'
      - boolean
    doc: write the reference sequence at the beginning of the file
    inputBinding:
      position: 101
      prefix: --prefix-ref
  - id: reference_fasta
    type: File
    doc: reference
    inputBinding:
      position: 101
      prefix: --reference
  - id: sam_file
    type: File
    doc: samfile
    inputBinding:
      position: 101
      prefix: --sam
  - id: stdout
    type:
      - 'null'
      - boolean
    doc: Overides -o/--output-fasta if present and prints output to stdout
    inputBinding:
      position: 101
      prefix: --stdout
  - id: trim
    type:
      - 'null'
      - string
    doc: trim the alignment to these coordinates (0-based, half-open)
    inputBinding:
      position: 101
      prefix: --trim
outputs:
  - id: output_fasta
    type:
      - 'null'
      - File
    doc: FASTA format file to write. Prints to stdout if not specified
    outputBinding:
      glob: $(inputs.output_fasta)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
