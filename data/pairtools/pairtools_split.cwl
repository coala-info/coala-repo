cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pairtools
  - split
label: pairtools_split
doc: "Split a .pairsam file into .pairs and .sam.\n\n  Restore a .sam file from sam1
  and sam2 fields of a .pairsam file. Create a\n  .pairs file without sam1/sam2 fields.\n\
  \nTool homepage: https://github.com/mirnylab/pairtools"
inputs:
  - id: pairsam_path
    type:
      - 'null'
      - File
    doc: "input .pairsam file. If the path ends with .gz or .lz4, the\n  input is
      decompressed by bgzip or lz4c. By default, the input is read from\n  stdin."
    inputBinding:
      position: 1
  - id: cmd_in
    type:
      - 'null'
      - string
    doc: 'A command to decompress the input file. If provided, fully overrides the
      auto-guessed command. Does not work with stdin and pairtools parse. Must read
      input from stdin and print output into stdout. EXAMPLE: pbgzip -dc -n 3'
    inputBinding:
      position: 102
      prefix: --cmd-in
  - id: cmd_out
    type:
      - 'null'
      - string
    doc: 'A command to compress the output file. If provided, fully overrides the
      auto-guessed command. Does not work with stdout. Must read input from stdin
      and print output into stdout. EXAMPLE: pbgzip -c -n 8'
    inputBinding:
      position: 102
      prefix: --cmd-out
  - id: nproc_in
    type:
      - 'null'
      - int
    doc: "Number of processes used by the auto-guessed input\n                   \
      \    decompressing command."
    default: 3
    inputBinding:
      position: 102
      prefix: --nproc-in
  - id: nproc_out
    type:
      - 'null'
      - int
    doc: "Number of processes used by the auto-guessed output\n                  \
      \     compressing command."
    default: 8
    inputBinding:
      position: 102
      prefix: --nproc-out
outputs:
  - id: output_pairs
    type:
      - 'null'
      - File
    doc: "output pairs file. If the path ends with .gz or .lz4,\n                \
      \       the output is bgzip-/lz4c-compressed. If -, pairs are\n            \
      \           printed to stdout. If not specified, pairs are dropped."
    outputBinding:
      glob: $(inputs.output_pairs)
  - id: output_sam
    type:
      - 'null'
      - File
    doc: "output sam file. If the path ends with .bam, the output\n              \
      \         is compressed into a bam file. If -, sam entries are\n           \
      \            printed to stdout. If not specified, sam entries are\n        \
      \               dropped."
    outputBinding:
      glob: $(inputs.output_sam)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pairtools:1.1.3--py310h4e61836_0
