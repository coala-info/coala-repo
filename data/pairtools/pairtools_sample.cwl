cwlVersion: v1.2
class: CommandLineTool
baseCommand: pairtools sample
label: pairtools_sample
doc: "Select a random subset of pairs in a pairs file.\n\nTool homepage: https://github.com/mirnylab/pairtools"
inputs:
  - id: fraction
    type: float
    doc: the fraction of the randomly selected pairs subset
    inputBinding:
      position: 1
  - id: pairs_path
    type:
      - 'null'
      - File
    doc: input .pairs/.pairsam file. If the path ends with .gz or .lz4, the 
      input is decompressed by bgzip/lz4c. By default, the input is read from 
      stdin.
    inputBinding:
      position: 2
  - id: cmd_in
    type:
      - 'null'
      - string
    doc: 'A command to decompress the input file. If provided, fully overrides the
      auto-guessed command. Does not work with stdin and pairtools parse. Must read
      input from stdin and print output into stdout. EXAMPLE: pbgzip -dc -n 3'
    inputBinding:
      position: 103
      prefix: --cmd-in
  - id: cmd_out
    type:
      - 'null'
      - string
    doc: 'A command to compress the output file. If provided, fully overrides the
      auto-guessed command. Does not work with stdout. Must read input from stdin
      and print output into stdout. EXAMPLE: pbgzip -c -n 8'
    inputBinding:
      position: 103
      prefix: --cmd-out
  - id: nproc_in
    type:
      - 'null'
      - int
    doc: Number of processes used by the auto-guessed input decompressing 
      command.
    default: 3
    inputBinding:
      position: 103
      prefix: --nproc-in
  - id: nproc_out
    type:
      - 'null'
      - int
    doc: Number of processes used by the auto-guessed output compressing 
      command.
    default: 8
    inputBinding:
      position: 103
      prefix: --nproc-out
  - id: seed
    type:
      - 'null'
      - int
    doc: the seed of the random number generator.
    inputBinding:
      position: 103
      prefix: --seed
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file. If the path ends with .gz or .lz4, the output is 
      bgzip-/lz4c-compressed. By default, the output is printed into stdout.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pairtools:1.1.3--py310h4e61836_0
