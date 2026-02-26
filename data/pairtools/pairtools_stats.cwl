cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pairtools
  - stats
label: pairtools_stats
doc: "Calculate pairs statistics.\n\nTool homepage: https://github.com/mirnylab/pairtools"
inputs:
  - id: input_path
    type:
      - 'null'
      - type: array
        items: File
    doc: by default, a .pairs/.pairsam file to calculate statistics. If not 
      provided, the input is read from stdin. If --merge is specified, then 
      INPUT_PATH is interpreted as an arbitrary number of stats files to merge.
    inputBinding:
      position: 1
  - id: bytile_dups
    type:
      - 'null'
      - boolean
    doc: If enabled, will analyse by-tile duplication statistics to estimate 
      library complexity more accurately. Requires parent_readID column to be 
      saved by dedup (will be ignored otherwise) Saves by-tile stats into 
      --output_bytile-stats stream, or regular output if --output_bytile-stats 
      is not provided.
    inputBinding:
      position: 102
      prefix: --bytile-dups
  - id: chrom_subset
    type:
      - 'null'
      - File
    doc: 'A path to a chromosomes file (tab-separated, 1st column contains chromosome
      names) containing a chromosome subset of interest. If provided, additionally
      filter pairs with both sides originating from the provided subset of chromosomes.
      This operation modifies the #chromosomes: and #chromsize: header fields accordingly.'
    inputBinding:
      position: 102
      prefix: --chrom-subset
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
  - id: engine
    type:
      - 'null'
      - string
    doc: Engine for regular expression parsing. Python will provide you regex 
      functionality, while pandas does not accept custom funtctions and works 
      faster.
    inputBinding:
      position: 102
      prefix: --engine
  - id: filter
    type:
      - 'null'
      - type: array
        items: string
    doc: "Filters with conditions to apply to the data (similar to `pairtools select`).
      For non-YAML output only the first filter will be reported. Example: pairtools
      stats --yaml --filter 'unique:(pair_type==\"UU\")' --filter 'close:(pair_type==\"\
      UU\") and (abs(pos1-pos2)<10)' test.pairs"
    inputBinding:
      position: 102
      prefix: --filter
  - id: merge
    type:
      - 'null'
      - boolean
    doc: If specified, merge multiple input stats files instead of calculating 
      statistics of a .pairs/.pairsam file. Merging is performed via summation 
      of all overlapping statistics. Non-overlapping statistics are appended to 
      the end of the file. Supported for tsv stats with single filter.
    inputBinding:
      position: 102
      prefix: --merge
  - id: n_dist_bins_decade
    type:
      - 'null'
      - int
    doc: Number of bins to split the distance range in log10-space, specified 
      per a factor of 10 difference.
    default: 8
    inputBinding:
      position: 102
      prefix: --n-dist-bins-decade
  - id: no_bytile_dups
    type:
      - 'null'
      - boolean
    doc: If enabled, will analyse by-tile duplication statistics to estimate 
      library complexity more accurately. Requires parent_readID column to be 
      saved by dedup (will be ignored otherwise) Saves by-tile stats into 
      --output_bytile-stats stream, or regular output if --output_bytile-stats 
      is not provided.
    inputBinding:
      position: 102
      prefix: --no-bytile-dups
  - id: no_chromsizes
    type:
      - 'null'
      - boolean
    doc: If enabled, will store sizes of chromosomes from the header of the 
      pairs file in the stats file.
    inputBinding:
      position: 102
      prefix: --no-chromsizes
  - id: no_yaml
    type:
      - 'null'
      - boolean
    doc: Output stats in yaml format instead of table.
    inputBinding:
      position: 102
      prefix: --no-yaml
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
  - id: startup_code
    type:
      - 'null'
      - string
    doc: An auxiliary code to execute before filtering. Use to define functions 
      that can be evaluated in the CONDITION statement
    inputBinding:
      position: 102
      prefix: --startup-code
  - id: type_cast
    type:
      - 'null'
      - type: array
        items: string
    doc: Cast a given column to a given type. By default, only pos and mapq are 
      cast to int, other columns are kept as str. Provide as -t <column_name> 
      <type>, e.g. -t read_len1 int. Multiple entries are allowed.
    inputBinding:
      position: 102
      prefix: --type-cast
  - id: with_chromsizes
    type:
      - 'null'
      - boolean
    doc: If enabled, will store sizes of chromosomes from the header of the 
      pairs file in the stats file.
    inputBinding:
      position: 102
      prefix: --with-chromsizes
  - id: yaml
    type:
      - 'null'
      - boolean
    doc: Output stats in yaml format instead of table.
    inputBinding:
      position: 102
      prefix: --yaml
outputs:
  - id: output_stats_file
    type:
      - 'null'
      - File
    doc: output stats tsv file.
    outputBinding:
      glob: $(inputs.output_stats_file)
  - id: output_bytile_stats
    type:
      - 'null'
      - File
    doc: output file for tile duplicate statistics. If file exists, it will be 
      open in the append mode. If the path ends with .gz or .lz4, the output is 
      bgzip-/lz4c-compressed. By default, by-tile duplicate statistics are not 
      printed. Note that the readID and parent_readID should be provided and 
      contain tile information for this option.
    outputBinding:
      glob: $(inputs.output_bytile_stats)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pairtools:1.1.3--py310h4e61836_0
