cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pairtools
  - restrict
label: pairtools_restrict
doc: "Assign restriction fragments to pairs.\n\nIdentify the restriction fragments
  that got ligated into a Hi-C molecule.\n\nNote: rfrags are 0-indexed\n\nTool homepage:
  https://github.com/mirnylab/pairtools"
inputs:
  - id: pairs_path
    type:
      - 'null'
      - File
    doc: "input .pairs/.pairsam file. If the path ends with .gz/.lz4, the\n  input
      is decompressed by bgzip/lz4c. By default, the input is read from\n  stdin."
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
  - id: frags
    type: File
    doc: "a tab-separated BED file with the positions of\n                       restriction
      fragments (chrom, start, end). Can be\n                       generated using
      cooler digest."
    inputBinding:
      position: 102
      prefix: --frags
  - id: nproc_in
    type:
      - 'null'
      - int
    doc: "Number of processes used by the auto-guessed input\n                   \
      \    decompressing command."
    inputBinding:
      position: 102
      prefix: --nproc-in
  - id: nproc_out
    type:
      - 'null'
      - int
    doc: "Number of processes used by the auto-guessed output\n                  \
      \     compressing command."
    inputBinding:
      position: 102
      prefix: --nproc-out
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: "output .pairs/.pairsam file. If the path ends with\n                   \
      \    .gz/.lz4, the output is compressed by bgzip/lz4c. By\n                \
      \       default, the output is printed into stdout."
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pairtools:1.1.3--py310h4e61836_0
