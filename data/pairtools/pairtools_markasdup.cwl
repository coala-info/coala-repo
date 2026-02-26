cwlVersion: v1.2
class: CommandLineTool
baseCommand: pairtools_markasdup
label: pairtools_markasdup
doc: "Tag all pairs in the input file as duplicates.\n\n  Change the type of all pairs
  inside a .pairs/.pairsam file to DD. If sam\n  entries are present, change the pair
  type in the Yt SAM tag to 'Yt:Z:DD'.\n\nTool homepage: https://github.com/mirnylab/pairtools"
inputs:
  - id: pairsam_path
    type:
      - 'null'
      - File
    doc: ".pairs/.pairsam file. If the path ends with .gz, the\n  input is gzip-decompressed.
      By default, the input is read from stdin."
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
  - id: output
    type:
      - 'null'
      - File
    doc: "output .pairsam file. If the path ends with .gz or\n                   \
      \    .lz4, the output is bgzip-/lz4c-compressed. By default,\n             \
      \          the output is printed into stdout."
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pairtools:1.1.3--py310h4e61836_0
