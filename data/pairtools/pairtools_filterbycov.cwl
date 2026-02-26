cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pairtools
  - filterbycov
label: pairtools_filterbycov
doc: "Remove pairs from regions of high coverage.\n\nTool homepage: https://github.com/mirnylab/pairtools"
inputs:
  - id: pairs_path
    type:
      - 'null'
      - File
    doc: input triu-flipped sorted .pairs or .pairsam file. If the path ends 
      with .gz/.lz4, the input is decompressed by bgzip/lz4c. By default, the 
      input is read from stdin.
    inputBinding:
      position: 1
  - id: c1
    type:
      - 'null'
      - int
    doc: Chrom 1 column
    default: 1
    inputBinding:
      position: 102
      prefix: --c1
  - id: c2
    type:
      - 'null'
      - int
    doc: Chrom 2 column
    default: 3
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
  - id: comment_char
    type:
      - 'null'
      - string
    doc: The first character of comment lines
    inputBinding:
      position: 102
      prefix: --comment-char
  - id: mark_multi
    type:
      - 'null'
      - boolean
    doc: If specified, duplicate pairs are marked as FF in "pair_type" and as a 
      duplicate in the sam entries.
    inputBinding:
      position: 102
      prefix: --mark-multi
  - id: max_cov
    type:
      - 'null'
      - int
    doc: The maximum allowed coverage per region.
    inputBinding:
      position: 102
      prefix: --max-cov
  - id: max_dist
    type:
      - 'null'
      - int
    doc: The resolution for calculating coverage. For each pair, the local 
      coverage around each end is calculated as (1 + the number of neighbouring 
      pairs within +/- max_dist bp)
    inputBinding:
      position: 102
      prefix: --max-dist
  - id: method
    type:
      - 'null'
      - string
    doc: calculate the number of neighbouring pairs as either the sum or the max
      of the number of neighbours on the two sides
    default: max
    inputBinding:
      position: 102
      prefix: --method
  - id: nproc_in
    type:
      - 'null'
      - int
    doc: Number of processes used by the auto-guessed input decompressing 
      command.
    default: 3
    inputBinding:
      position: 102
      prefix: --nproc-in
  - id: nproc_out
    type:
      - 'null'
      - int
    doc: Number of processes used by the auto-guessed output compressing 
      command.
    default: 8
    inputBinding:
      position: 102
      prefix: --nproc-out
  - id: p1
    type:
      - 'null'
      - int
    doc: Position 1 column
    default: 2
    inputBinding:
      position: 102
      prefix: --p1
  - id: p2
    type:
      - 'null'
      - int
    doc: Position 2 column
    default: 4
    inputBinding:
      position: 102
      prefix: --p2
  - id: s1
    type:
      - 'null'
      - int
    doc: Strand 1 column
    default: 5
    inputBinding:
      position: 102
      prefix: --s1
  - id: s2
    type:
      - 'null'
      - int
    doc: Strand 2 column
    default: 6
    inputBinding:
      position: 102
      prefix: --s2
  - id: send_header_to
    type:
      - 'null'
      - string
    doc: Which of the outputs should receive header and comment lines
    inputBinding:
      position: 102
      prefix: --send-header-to
  - id: sep
    type:
      - 'null'
      - string
    doc: Separator (\t, \v, etc. characters are supported, pass them in quotes)
    inputBinding:
      position: 102
      prefix: --sep
  - id: unmapped_chrom
    type:
      - 'null'
      - string
    doc: Placeholder for a chromosome on an unmapped side
    default: '!'
    inputBinding:
      position: 102
      prefix: --unmapped-chrom
outputs:
  - id: output_lowcov
    type:
      - 'null'
      - File
    doc: output file for pairs from low coverage regions. If the path ends with 
      .gz or .lz4, the output is bgzip-/lz4c-compressed. By default, the output 
      is printed into stdout.
    outputBinding:
      glob: $(inputs.output_lowcov)
  - id: output_highcov
    type:
      - 'null'
      - File
    doc: output file for pairs from high coverage regions. If the path ends with
      .gz or .lz4, the output is bgzip-/lz4c-compressed. If the path is the same
      as in --output or -, output duplicates together with deduped pairs. By 
      default, duplicates are dropped.
    outputBinding:
      glob: $(inputs.output_highcov)
  - id: output_unmapped
    type:
      - 'null'
      - File
    doc: output file for unmapped pairs. If the path ends with .gz or .lz4, the 
      output is bgzip-/lz4c-compressed. If the path is the same as in --output 
      or -, output unmapped pairs together with deduped pairs. If the path is 
      the same as --output-highcov, output unmapped reads together. By default, 
      unmapped pairs are dropped.
    outputBinding:
      glob: $(inputs.output_unmapped)
  - id: output_stats
    type:
      - 'null'
      - File
    doc: output file for statistics of multiple interactors. If file exists, it 
      will be open in the append mode. If the path ends with .gz or .lz4, the 
      output is bgzip-/lz4c-compressed. By default, statistics are not printed.
    outputBinding:
      glob: $(inputs.output_stats)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pairtools:1.1.3--py310h4e61836_0
