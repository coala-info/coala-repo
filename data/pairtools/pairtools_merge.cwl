cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pairtools
  - merge
label: pairtools_merge
doc: "Merge .pairs/.pairsam files. By default, assumes that the files are sorted and
  maintains the sorting.\n\nTool homepage: https://github.com/mirnylab/pairtools"
inputs:
  - id: pairs_paths
    type:
      - 'null'
      - type: array
        items: File
    doc: upper-triangular flipped sorted .pairs/.pairsam files to merge or a 
      group/groups of .pairs/.pairsam files specified by a wildcard. For paths 
      ending in .gz/.lz4, the files are decompressed by bgzip/lz4c.
    inputBinding:
      position: 1
  - id: cmd_in
    type:
      - 'null'
      - string
    doc: 'A command to decompress the input. If provided, fully overrides the auto-guessed
      command. Does not work with stdin. Must read input from stdin and print output
      into stdout. EXAMPLE: pbgzip -dc -n 3'
    inputBinding:
      position: 102
      prefix: --cmd-in
  - id: cmd_out
    type:
      - 'null'
      - string
    doc: 'A command to compress the output. If provided, fully overrides the auto-guessed
      command. Does not work with stdout. Must read input from stdin and print output
      into stdout. EXAMPLE: pbgzip -c -n 8'
    inputBinding:
      position: 102
      prefix: --cmd-out
  - id: compress_program
    type:
      - 'null'
      - string
    doc: 'A binary to compress temporary merged chunks. Must decompress input when
      the flag -d is provided. Suggested alternatives: lz4c, gzip, lzop, snzip. NOTE:
      fails silently if the command syntax is wrong.'
    inputBinding:
      position: 102
      prefix: --compress-program
  - id: concatenate
    type:
      - 'null'
      - boolean
    doc: Simple concatenate instead of merging sorted files.
    inputBinding:
      position: 102
      prefix: --concatenate
  - id: keep_first_header
    type:
      - 'null'
      - boolean
    doc: Keep the first header
    inputBinding:
      position: 102
      prefix: --keep-first-header
  - id: max_nmerge
    type:
      - 'null'
      - int
    doc: The maximal number of inputs merged at once. For more, store merged 
      intermediates in temporary files.
    inputBinding:
      position: 102
      prefix: --max-nmerge
  - id: memory
    type:
      - 'null'
      - string
    doc: The amount of memory used by default.
    inputBinding:
      position: 102
      prefix: --memory
  - id: no_concatenate
    type:
      - 'null'
      - boolean
    doc: Simple concatenate instead of merging sorted files.
    inputBinding:
      position: 102
      prefix: --no-concatenate
  - id: no_keep_first_header
    type:
      - 'null'
      - boolean
    doc: merge the headers together
    inputBinding:
      position: 102
      prefix: --no-keep-first-header
  - id: nproc
    type:
      - 'null'
      - int
    doc: Number of threads for merging.
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
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: Custom temporary folder for merged intermediates.
    inputBinding:
      position: 102
      prefix: --tmpdir
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file. If the path ends with .gz/.lz4, the output is compressed 
      by bgzip/lz4c. By default, the output is printed into stdout.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pairtools:1.1.3--py310h4e61836_0
