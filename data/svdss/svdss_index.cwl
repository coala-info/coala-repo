cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - SVDSS
  - index
label: svdss_index
doc: "Build the FMD index of a reference genome (wrapper around ropebwt3 build)\n\nTool homepage: https://github.com/Parsoa/SVDSS"
inputs:
  - id: reference
    type: File
    doc: "Reference FASTA (positional argument of ropebwt3 build)."
    inputBinding:
      position: 102
  - id: batch_size
    type:
      - 'null'
      - string
    doc: "Batch size [7G]."
    inputBinding:
      position: 101
      prefix: -m
  - id: threads
    type:
      - 'null'
      - int
    doc: "Total number of threads [4]."
    inputBinding:
      position: 101
      prefix: -t
  - id: sais_threads
    type:
      - 'null'
      - int
    doc: "Threads for sais and run sais and merge together (more RAM) [0]."
    inputBinding:
      position: 101
      prefix: -p
  - id: leaf_block_size
    type:
      - 'null'
      - int
    doc: "Leaf block size in B+-tree [512]."
    inputBinding:
      position: 101
      prefix: -l
  - id: max_children
    type:
      - 'null'
      - int
    doc: "Max number children per internal node [64]."
    inputBinding:
      position: 101
      prefix: -n
  - id: ropebwt2
    type:
      - 'null'
      - boolean
    doc: "Use the ropebwt2 algorithm (libsais by default)."
    inputBinding:
      position: 101
      prefix: "-2"
  - id: rlo
    type:
      - 'null'
      - boolean
    doc: "Build BWT in the reverse lexicographical order (RLO; force -2)."
    inputBinding:
      position: 101
      prefix: -s
  - id: rclo
    type:
      - 'null'
      - boolean
    doc: "Build BWT in RCLO (force -2)."
    inputBinding:
      position: 101
      prefix: -r
  - id: existing_index
    type:
      - 'null'
      - File
    doc: "Read existing index from FILE."
    inputBinding:
      position: 101
      prefix: -i
  - id: one_per_line
    type:
      - 'null'
      - boolean
    doc: "One sequence per line in the input."
    inputBinding:
      position: 101
      prefix: -L
  - id: no_forward
    type:
      - 'null'
      - boolean
    doc: "No forward strand."
    inputBinding:
      position: 101
      prefix: -F
  - id: no_reverse
    type:
      - 'null'
      - boolean
    doc: "No reverse strand."
    inputBinding:
      position: 101
      prefix: -R
  - id: dump_fmd
    type:
      - 'null'
      - boolean
    doc: "Dump in the fermi-delta format (FMD)."
    inputBinding:
      position: 101
      prefix: -d
  - id: dump_fmr
    type:
      - 'null'
      - boolean
    doc: "Dump in the ropebwt format (FMR)."
    inputBinding:
      position: 101
      prefix: -b
  - id: newick
    type:
      - 'null'
      - boolean
    doc: "Output the index in the Newick format (for debugging)."
    inputBinding:
      position: 101
      prefix: -T
  - id: output_file
    type:
      - 'null'
      - string
    doc: "Output to FILE (default: standard output)."
    inputBinding:
      position: 101
      prefix: -o
  - id: save_index
    type:
      - 'null'
      - string
    doc: "Save the current index to FILE after each input file."
    inputBinding:
      position: 101
      prefix: -S
outputs:
  - id: index_file
    type:
      - 'null'
      - File
    doc: Index written to the -o file, when given.
    outputBinding:
      glob: $(inputs.output_file)
  - id: fmd_index
    type: stdout
    doc: Index written to standard output (use -d for the FMD format).
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svdss:2.1.0--h9013031_0
stdout: index.fmd
