cwlVersion: v1.2
class: CommandLineTool
baseCommand: pairtools_sort
label: pairtools_sort
doc: "Sort a .pairs/.pairsam file.\n\nSort pairs in the lexicographic order along
  chrom1 and chrom2, in the\nnumeric order along pos1 and pos2 and in the lexicographic
  order along\npair_type.\n\nTool homepage: https://github.com/mirnylab/pairtools"
inputs:
  - id: pairs_path
    type:
      - 'null'
      - File
    doc: input .pairs/.pairsam file. If the path ends with .gz or .lz4, the 
      input is decompressed by bgzip or lz4c, correspondingly. By default, the 
      input is read as text from stdin.
    inputBinding:
      position: 1
  - id: chrom1_col
    type:
      - 'null'
      - string
    doc: Chrom 1 column; default chrom1[input format option]
    inputBinding:
      position: 102
      prefix: --c1
  - id: chrom2_col
    type:
      - 'null'
      - string
    doc: Chrom 2 column; default chrom2[input format option]
    inputBinding:
      position: 102
      prefix: --c2
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
  - id: compress_program
    type:
      - 'null'
      - string
    doc: 'A binary to compress temporary sorted chunks. Must decompress input when
      the flag -d is provided. Suggested alternatives: gzip, lzop, lz4c, snzip. If
      "auto", then use lz4c if available, and gzip otherwise.'
    inputBinding:
      position: 102
      prefix: --compress-program
  - id: extra_col
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Extra column (name or numerical index) that is also used for sorting.The
      option can be provided multiple times.Example: --extra-col "phase1" --extra-col
      "phase2". [output format option]'
    inputBinding:
      position: 102
      prefix: --extra-col
  - id: memory
    type:
      - 'null'
      - string
    doc: The amount of memory used by default.
    inputBinding:
      position: 102
      prefix: --memory
  - id: nproc
    type:
      - 'null'
      - int
    doc: Number of processes to split the sorting work between.
    inputBinding:
      position: 102
      prefix: --nproc
  - id: nproc_in
    type:
      - 'null'
      - int
    doc: Number of processes used by the auto-guessed input decompressing 
      command.
    inputBinding:
      position: 102
      prefix: --nproc-in
  - id: nproc_out
    type:
      - 'null'
      - int
    doc: Number of processes used by the auto-guessed output compressing 
      command.
    inputBinding:
      position: 102
      prefix: --nproc-out
  - id: pair_type_col
    type:
      - 'null'
      - string
    doc: Pair type column; default pair_type[input format option]
    inputBinding:
      position: 102
      prefix: --pt
  - id: pos1_col
    type:
      - 'null'
      - string
    doc: Position 1 column; default pos1[input format option]
    inputBinding:
      position: 102
      prefix: --p1
  - id: pos2_col
    type:
      - 'null'
      - string
    doc: Position 2 column; default pos2[input format option]
    inputBinding:
      position: 102
      prefix: --p2
  - id: tmpdir
    type:
      - 'null'
      - string
    doc: Custom temporary folder for sorting intermediates.
    inputBinding:
      position: 102
      prefix: --tmpdir
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: output pairs file. If the path ends with .gz or .lz4, the output is 
      compressed by bgzip or lz4, correspondingly. By default, the output is 
      printed into stdout.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pairtools:1.1.3--py310h4e61836_0
