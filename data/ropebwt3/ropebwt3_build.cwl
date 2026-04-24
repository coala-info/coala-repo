cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ropebwt3
  - build
label: ropebwt3_build
doc: "Builds a BWT index for a FASTA file.\n\nTool homepage: https://github.com/lh3/ropebwt3"
inputs:
  - id: input_fa
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 1
  - id: batch_size
    type:
      - 'null'
      - string
    doc: batch size
    inputBinding:
      position: 102
      prefix: -m
  - id: dump_bre
    type:
      - 'null'
      - boolean
    doc: dump in the BRE format
    inputBinding:
      position: 102
      prefix: -e
  - id: dump_fermi_delta
    type:
      - 'null'
      - boolean
    doc: dump in the fermi-delta format (FMD)
    inputBinding:
      position: 102
      prefix: -d
  - id: dump_ropebwt
    type:
      - 'null'
      - boolean
    doc: dump in the ropebwt format (FMR)
    inputBinding:
      position: 102
      prefix: -b
  - id: existing_index_file
    type:
      - 'null'
      - File
    doc: read existing index from FILE
    inputBinding:
      position: 102
      prefix: -i
  - id: leaf_block_size
    type:
      - 'null'
      - int
    doc: leaf block size in B+-tree
    inputBinding:
      position: 102
      prefix: -l
  - id: max_internal_node_children
    type:
      - 'null'
      - int
    doc: max number children per internal node
    inputBinding:
      position: 102
      prefix: -n
  - id: no_forward_strand
    type:
      - 'null'
      - boolean
    doc: no forward strand
    inputBinding:
      position: 102
      prefix: -F
  - id: no_reverse_strand
    type:
      - 'null'
      - boolean
    doc: no reverse strand
    inputBinding:
      position: 102
      prefix: -R
  - id: one_sequence_per_line
    type:
      - 'null'
      - boolean
    doc: one sequence per line in the input
    inputBinding:
      position: 102
      prefix: -L
  - id: output_file
    type:
      - 'null'
      - File
    doc: output to FILE
    inputBinding:
      position: 102
      prefix: -o
  - id: output_newick_format
    type:
      - 'null'
      - boolean
    doc: output the index in the Newick format (for debugging)
    inputBinding:
      position: 102
      prefix: -T
  - id: rcl_order
    type:
      - 'null'
      - boolean
    doc: build BWT in RCLO (force -2)
    inputBinding:
      position: 102
      prefix: -r
  - id: reverse_lexicographical_order
    type:
      - 'null'
      - boolean
    doc: build BWT in the reverse lexicographical order (RLO; force -2)
    inputBinding:
      position: 102
      prefix: -s
  - id: sais_threads
    type:
      - 'null'
      - int
    doc: '#threads for sais and run sais and merge together (more RAM)'
    inputBinding:
      position: 102
      prefix: -p
  - id: save_index_file
    type:
      - 'null'
      - File
    doc: save the current index to FILE after each input file
    inputBinding:
      position: 102
      prefix: -S
  - id: threads
    type:
      - 'null'
      - int
    doc: total number of threads
    inputBinding:
      position: 102
      prefix: -t
  - id: use_ropebwt2
    type:
      - 'null'
      - boolean
    doc: use the ropebwt2 algorithm (libsais by default)
    inputBinding:
      position: 102
      prefix: '-2'
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ropebwt3:3.10--h577a1d6_0
stdout: ropebwt3_build.out
