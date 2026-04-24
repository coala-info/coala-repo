cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pairtools
  - flip
label: pairtools_flip
doc: "Flip pairs to get an upper-triangular matrix.\n\nTool homepage: https://github.com/mirnylab/pairtools"
inputs:
  - id: pairs_path
    type:
      - 'null'
      - File
    doc: input .pairs/.pairsam file. If the path ends with .gz or .lz4, the 
      input is decompressed by bgzip/lz4c. By default, the input is read from 
      stdin.
    inputBinding:
      position: 1
  - id: chroms_path
    type: File
    doc: 'Chromosome order used to flip interchromosomal mates: path to a chromosomes
      file (e.g. UCSC chrom.sizes or similar) whose first column lists scaffold names.
      Any scaffolds not listed will be ordered lexicographically following the names
      provided.'
    inputBinding:
      position: 102
      prefix: --chroms-path
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
